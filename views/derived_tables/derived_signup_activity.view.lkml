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
    label: "Sign Up Activities - Object ID"
    type: number
    sql: ${TABLE}.ObjectID ;;
  }

  measure: count {
    label: "Count - Sign Up Activities"
    type: count
    drill_fields: [detail*]
  }

  measure: percent_of_total {
    label: "Percent of Total - Sign Up Activities"
    type: percent_of_total
    sql: ${count} ;;
    drill_fields: [detail*]
  }

#COUNT OF SPECIFIC ACTIVITY TYPES A USER HAS COMPLETED
#count - has accessed article
#  measure: count_articles {
#    group_label: "Sign Up Activity Counts"
#    label: "Count - Articles"
#    type: count
#    filters: [object_type: "article"]
#  }


  dimension: uid {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count_users {
    label: "Count - Unique Users with Sign Up Activity"
    type: count_distinct
    sql: ${TABLE}.user_id ;;
    drill_fields: [detail*]
  }

#calculate average users with activity
  measure: activites_per_user {
    label: "Average - Sign Up Activities per user"
    description: "Number activities (articles read, weights tracked) divided by number of unique users"
    type: number
    sql: ${count} / ${count_users} ;;
    drill_fields: [detail*]
  }



#v2 - replaced with has done activity in derived_characteristics
  measure:  has_done_activity{
    view_label: "1. User Account"
    label: "User Has Done Sign Up Activity - Yes/No"
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
    label: "Sign Up Activities - Value"
    type: string
    sql: ${TABLE}.ObjectValue ;;
  }

  dimension: postcode_object {
    label: "Sign Up Activities - Postcode"
    type: string
    sql: CASE WHEN ${object_type} = "pops-address" THEN ${TABLE}.ObjectValue
    ELSE NULL
    END;;
  }


  dimension: postcode_location {
    label: "Postcode Map Data"
    type: string
    map_layer_name: uk_postcode_areas
    sql: ${postcode_object} ;;
  }

  dimension: postcode_testing_validation {
    label: "Sign Up Activities - Postcode"
    sql:  REPLACE(${postcode_object}, " ", "")
    ;;
  ###  sql: INSERT PARCING SQL HERE
  }

  dimension: object_type {
    label: "Sign Up Activities - Type"
    type: string
    sql: ${TABLE}.ObjectType ;;
  }

  dimension_group: object_accessed_date {
    label: "Sign Up Activities - Activity Completed"
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
  dimension_group: signup_event {
    hidden: yes
    #label: ""
    type: time
    timeframes: [raw,time,date,week,month, hour_of_day, day_of_week,day_of_month]
    sql: ${TABLE}.event ;;
  }

#TIME DIFFERENCE MEASURES/DIMENSIONS
  #MIN and MAX measures must be type: date, then use SQL in order to calculate
  #EARLIEST ACTIVITY
  measure: min_signup_event {
    view_label: "1. User Account"
    label: "First Sign Up activity"
    #hidden: yes
    type: date
    sql: MIN(${signup_event_raw}) ;;
  }

  measure: days_since_min_signup_event {
    view_label: "1. User Account"
    label: "Days since first signup activity"
    type: number
    sql:DATEDIFF(now(), MIN(${signup_event_raw})) ;;
  }

#LATEST ACTIVITY
  measure: max_signup_event {
    view_label: "1. User Account"
    label: "Latest signup activity"
    type: date
    sql: MAX(${signup_event_raw}) ;;
  }

  measure: days_since_max_signup_event {
    group_label: "Activity Time Measures"
    label: "Days since latest activity"
    type: number
    sql:DATEDIFF(now(), MAX(${signup_event_raw})) ;;
  }

  dimension_group: since_account_creation_and_signup {
    group_label: "Signup Activity Time Measures"
    label: "between Account Creation and Signup Activity"
    description: "When used with CHUID, shows amount of time between this activity and the users account creation"
    type: duration
    intervals: [day, week, month, hour,minute]
    sql_start: ${users.created_raw} ;;
    sql_end: ${signup_event_raw} ;;
  }


  set: detail {
    fields: [
      users.ppuid,
    ]
  }


}
