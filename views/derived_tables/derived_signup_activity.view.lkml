view: derived_signup_activity {

  derived_table: {
    sql:
            SELECT
              user_event_logs.user_id,
              user_event_logs.id "ObjectID",
              user_event_logs.event_type "ObjectValue",
              'status change' as "ObjectType",
              user_event_logs.created_at "event"
            FROM  userhub.user_event_logs
            UNION
            SELECT
                 personal_data_store.optional_data.user_id,
                 personal_data_store.optional_data.id "ObjectID",
                 personal_data_store.optional_data.value "ObjectValue",
                 CONCAT("pops-", personal_data_store.optional_data.scope) as "ObjectType",
                 personal_data_store.optional_data.created_at "event"
            FROM  personal_data_store.optional_data
            UNION
            SELECT
                 opd.pops_data_replica.user_id,
                 opd.pops_data_replica.id "ObjectID",
                 opd.pops_data_replica.value "ObjectValue",
                 CONCAT("pops-", opd.pops_data_replica.scope) as "ObjectType",
                 opd.pops_data_replica.created_at "event"
            FROM  opd.pops_data_replica
            ORDER BY user_id, event
       ;;
  }

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

#count - has had coach appointment
  measure: count_plugin {
    group_label: "Test Activity Counts"
    label: "Count - Accessed Plugins"
    type: count
    filters: [object_type: "plugins"]
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

#TIME DIFFERENCE MEASURES/DIMENSIONS
  #MIN and MAX measures must be type: date, then use SQL in order to calculate
  #EARLIEST ACTIVITY
  measure: min_event {
    view_label: "1. User Account"
    label: "First activity"
    #hidden: yes
    type: date
    sql: MIN(${event_raw}) ;;
  }

  measure: days_since_min_event {
    view_label: "1. User Account"
    label: "Days since first activity"
    type: number
    sql:DATEDIFF(now(), MIN(${event_raw})) ;;
  }

#LATEST ACTIVITY
  measure: max_event {
    view_label: "1. User Account"
    label: "Latest activity"
    type: date
    sql: MAX(${event_raw}) ;;
  }

  measure: days_since_max_event {
    group_label: "Activity Time Measures"
    label: "Days since latest activity"
    type: number
    sql:DATEDIFF(now(), MAX(${event_raw})) ;;
  }

  dimension_group: since_account_creation {
    group_label: "Activity Time Measures"
    label: "between Account Creation and Activity"
    description: "When used with CHUID, shows amount of time between this activity and the users account creation"
    type: duration
    intervals: [day, week, month, hour,minute]
    sql_start: ${users.created_raw} ;;
    sql_end: ${event_raw} ;;
  }

#added 12/01 SL
  dimension: mnth_since_last_event {
    group_label: "Activity Time Measures"
    label: "Months Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.mnth_since_last_event ;;
  }
#added 12/01 SL
  dimension: week_since_last_event {
    group_label: "Activity Time Measures"
    label: "Weeks Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.week_since_last_event ;;
  }
#added 12/01 SL
  dimension: days_since_last_event {
    group_label: "Activity Time Measures"
    label: "Days Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.days_since_last_event ;;
  }

  dimension: mins_since_last_event {
    group_label: "Activity Time Measures"
    label: "Mins Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.mins_since_last_event;
        }

        dimension: secs_since_last_event {
          group_label: "Activity Time Measures"
          label: "Seconds Since Previous Event"
          #hidden: yes
          type: number
          drill_fields: [detail*]
          sql: ${TABLE}.secs_since_last_event;;
  }

  measure: sum_secs_since_last_event {
    group_label: "Activity Time Measures"
    label: "Count - Seconds Since Previous Event"
    #hidden: yes
    type: sum
    drill_fields: [detail*]
    sql: ${TABLE}.secs_since_last_event ;;
  }

  measure: sum_derived_mins_since_last_event {
    group_label: "Activity Time Measures"
    label: "Count - Minutes Since Previous Event"
    #hidden: yes
    type: sum
    drill_fields: [detail*]
    sql: ROUND(${TABLE}.secs_since_last_event / 60, 1) < 10 ;;
  }

  measure: sum_derived_mins_since_last_event_per_user{
    group_label: "Activity Time Measures"
    label: "Average - Minutes Since Previous Event, Per User"
    #hidden: yes
    type: number
    value_format: "0.##"
    drill_fields: [detail*]
    sql: ${sum_derived_mins_since_last_event} / ${count_users} ;;
  }

#SESSION DIMENSIONS
  dimension: is_new_session {
    group_label: "Sessions"
    hidden: yes
    type: number
    sql: ${TABLE}.is_new_session ;;
  }

  dimension: session_id {
    hidden: yes
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_session_sequence {
    group_label: "Sessions"
    label: "Session Number"
    description: "Is this the user's 1st session, or their 3rd, etc."
    type: number
    sql: ${TABLE}.user_session_sequence ;;
  }

  measure: max_sessions {
    group_label: "Sessions"
    label: "Maximum session count"
    type: max
    sql: ${TABLE}.user_session_sequence ;;
    description: "Highest session count by this participant"
  }

  set: detail {
    fields: [
      uid,
      is_new_session,
      session_id,
      user_session_sequence
    ]
  }


}
