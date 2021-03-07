view: derived_activity_2 {

  derived_table: {
    sql:
            SELECT
                 article.articles_accessed.user_id,
                 article.articles.id "ObjectID",
                 articles.name "ObjectValue",
                 articles.type as "ObjectType",
                 article.articles_accessed.created_at "event"
            FROM  article.articles_accessed
            JOIN article.articles ON article.articles_accessed.article_id  = article.articles.id
            UNION
            SELECT
                 program.plugins_accessed.user_id,
                 program.plugins.id "ObjectID",
                 program.plugins.system_name "ObjectValue",
                 'plugins' as "ObjectType",
                 program.plugins_accessed.created_at "event"
            FROM program.plugins_accessed
            JOIN program.plugins ON program.plugins_accessed.plugin_id = program.plugins.id
            UNION
            SELECT
                 plugin_weight.weight_tracks.user_id,
                 plugin_weight.weight_tracks.id "ObjectID",
                 plugin_weight.weight_tracks.weight_goal "ObjectValue",
                 'weight tracker' as "ObjectType",
                 plugin_weight.weight_tracks.created_at "event"
            FROM  plugin_weight.weight_tracks
            UNION
            SELECT
                 plugin_food.food_tracks.user_id,
                 plugin_food.food_tracks.id "ObjectID",
                 plugin_food.food_tracks.label_foods "ObjectValue",
                 'food tracker' as "ObjectType",
                 plugin_food.food_tracks.created_at "event"
            FROM  plugin_food.food_tracks
            UNION
            SELECT
                 coaching.appointments.user_id,
                 coaching.appointments.id "ObjectID",
                 coaching.appointments.result "ObjectValue",
                 'appointment' as "ObjectType",
                 coaching.appointments.since "event"
            FROM  coaching.appointments
            UNION
            SELECT
                 plugin_goal.goals.user_id,
                 plugin_goal.goals.id "ObjectID",
                 plugin_goal.profiles.name "ObjectValue",
                 'goals' as "ObjectType",
                 plugin_goal.goals.created_at "event"
            FROM plugin_goal.goals
            JOIN plugin_goal.profiles ON plugin_goal.goals.profile_id = plugin_goal.profiles.id
       ;;
      indexes: ["event"]
  }

#fit track removed to see if it improves query time
#            SELECT
#                 step.fit_tracks.user_id,
#                 step.fit_tracks.id "ObjectID",
#                 step.fit_tracks.logging_steps "ObjectValue",
#                 'step tracker' as "ObjectType",
#                 step.fit_tracks.created_at "event"
#            FROM  step.fit_tracks
#            UNION


  #PRIMARY KEY
  dimension: object_id {
    primary_key: yes
    label: "All Activities - Object ID"
    type: number
    sql: ${TABLE}.ObjectID ;;
  }

  measure: count {
    label: "Count - All Activities"
    type: count
    drill_fields: [detail*]
  }

  measure: percent_of_total {
    label: "Percent of Total - All Activities"
    type: percent_of_total
    sql: ${count} ;;
    drill_fields: [detail*]
  }

#COUNT OF SPECIFIC ACTIVITY TYPES A USER HAS COMPLETED
#count - has accessed article
  measure: count_articles {
    group_label: "Test Activity Counts"
    label: "Count - Articles"
    type: count
    filters: [object_type: "article"]
  }
#count - has watched video
  measure: count_video {
    group_label: "Test Activity Counts"
    label: "Count - Videos"
    type: count
    filters: [object_type: "video"]
  }
#count - has recorded a weight
  measure: count_weight {
    group_label: "Test Activity Counts"
    label: "Count - Weights"
    type: count
    filters: [object_type: "weight tracker"]
  }
#count - has recorded steps
  measure: count_steps {
    group_label: "Test Activity Counts"
    label: "Count - Steps"
    type: count
    filters: [object_type: "step tracker"]
  }
#count - has recorded steps
  measure: count_food {
    group_label: "Test Activity Counts"
    label: "Count - Food Tracker"
    type: count
    filters: [object_type: "food tracker"]
  }
#count - has accessed reading room
#  measure: count_reading_room {
#    label: "Count - Reading Room"
#    type: count
#    filters: [object_type: "article"]
#  }
##count - has accessed blood tracker
#  measure: count_blood_tracker {
#    label: "Count - Blood Tracker"
#    type: count
#    filters: [object_type: "article"]
#  }
#count - has accessed goals
  measure: count_goal {
    group_label: "Test Activity Counts"
    label: "Count - Goals"
    type: count
    filters: [object_type: "goals"]
  }

#count - has had coach appointment
  measure: count_appt {
    group_label: "Test Activity Counts"
    label: "Count - Coach Appointment"
    type: count
    filters: [object_type: "appointment"]
  }

#count - has used blood glucose tracker
  measure: count_blood_glucose {
    group_label: "Test Activity Counts"
    label: "Count - Accessed Blood Glucose Tracker"
    type: count
    filters: [object_type: "plugins", object_value: "Blood Glucose Tracking"]
  }

#count - has used blood glucose tracker
  measure: count_reading_room {
    group_label: "Test Activity Counts"
    label: "Count - Accessed Reading Room"
    type: count
    filters: [object_type: "plugins", object_value: "Reading room"]
  }


  dimension: uid {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count_users {
    label: "Count - Unique Users with Activity"
    type: count_distinct
    sql: ${TABLE}.user_id ;;
    drill_fields: [detail*]
  }

#calculate average users with activity
  measure: activites_per_user {
    label: "Average - Activities per user"
    description: "Number activities (articles read, weights tracked) divided by number of unique users"
    type: number
    sql: ${count} / ${count_users} ;;
    drill_fields: [detail*]
  }



#v2 - replaced with has done activity in derived_characteristics
  #@ISOBEL example of converting count into yesno
  measure:  has_done_activity{
    view_label: "1. User Account"
    label: "User Has Done Activity - Yes/No"
    type: yesno
    case: {
      when: {
        sql: ${count} > 0 ;;
        label: "Yes"
      }
      else: "No"
    }
  }


  dimension: object_value {
    label: "All Activities - Value"
    type: string
    sql: ${TABLE}.ObjectValue ;;
  }

  dimension: object_type {
    label: "All Activities - Type"
    type: string
    sql: ${TABLE}.ObjectType ;;
  }

  dimension_group: object_accessed_date {
    label: "All Activities - Activity Completed"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      minute15,
      day_of_week,
      day_of_month,
      day_of_year,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.event ;;
  }

#TIME DIFFERENCE MEASURES/DIMENSIONS
  dimension_group: event {
    hidden: yes
    #label: ""
    type: time
    timeframes: [raw,time,date,week,month, hour_of_day, day_of_week,day_of_month]
    sql: ${TABLE}.event ;;
  }


  set: detail {
    fields: [
      uid,

    ]
  }


}
