view: derived_activity_2 {

  derived_table: {
    #ISOBEL: ADD IN ALL PLATFORM USAGE (EG, PLUGINS, GOALS)
    sql: SELECT
      *,
      SUM(is_new_session) over (order by user_id,event) as `session_id`,
      SUM(is_new_session) over (partition by user_id order by event) as `user_session_sequence`
      FROM
      ( SELECT *,
        mins_since_last_event > 10 or mins_since_last_event is null as `is_new_session`
        FROM (SELECT
        *,
        TIMESTAMPDIFF(MONTH,lag(event) over (partition by user_id order by event), event) as `mnth_since_last_event`,
        TIMESTAMPDIFF(WEEK,lag(event) over (partition by user_id order by event), event) as `week_since_last_event`,
        TIMESTAMPDIFF(DAY,lag(event) over (partition by user_id order by event), event) as `days_since_last_event`,
        TIMESTAMPDIFF(MINUTE,lag(event) over (partition by user_id order by event), event) as `mins_since_last_event`,
        TIMESTAMPDIFF(SECOND,lag(event) over (partition by user_id order by event), event) as `secs_since_last_event`
          FROM (
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
                 program.plugins.system_name "ObjectName",
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
                 step.fit_tracks.user_id,
                 step.fit_tracks.id "ObjectID",
                 step.fit_tracks.logging_steps "ObjectValue",
                 'step tracker' as "ObjectType",
                 step.fit_tracks.created_at "event"
            FROM  step.fit_tracks
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
            ORDER BY user_id, event
            ) as events ) as events_lag
          ) events_session_flag
       ;;
  }


  measure: count {
    label: "Count - All Activities"
    type: count
    drill_fields: [detail*]
  }

  dimension: uid {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count_users {
    label: "Count - Users with Activity"
    type: count_distinct
    sql: ${TABLE}.user_id ;;
    drill_fields: [detail*]
  }

#  measure:  has_done_activity{
#    label: "User Has Done Activity"
#    type: yesno
#    sql: ${count_users} > 0 ;;
#  }

#v2
  measure:  has_done_activity{
    label: "User Has Done Activity"
    case: {
      when: {
        sql: ${count_users} > 0 ;;
        label: "1"
      }
      else: "0"
    }
  }

  dimension: object_id {
    primary_key: yes
    label: "All Activities - Object ID"
    type: number
    sql: ${TABLE}.ObjectID ;;
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

  dimension: is_new_session {
    hidden: yes
    type: number
    sql: ${TABLE}.is_new_session ;;
  }

  dimension: session_id {
    #hidden: yes
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_session_sequence {
    label: "Sessions"
    description: "Is this the user's 1st session, or their 3rd, etc."
    type: number
    sql: ${TABLE}.user_session_sequence ;;
  }



  set: detail {
    fields: [
      uid,
      is_new_session,
      session_id,
      user_session_sequence
    ]
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


}
