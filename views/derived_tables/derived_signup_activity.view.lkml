view: derived_signup_activity {

  derived_table: {
    sql:
            SELECT
              user_event_logs.user_id,
              user_event_logs.id "ObjectID",
              user_event_logs.event_type "ObjectValue",
              user_event_logs.payload "Key",
              'status change' as "ObjectType",
              user_event_logs.created_at "event"
            FROM  userhub.user_event_logs
            UNION
            SELECT
                 personal_data_store.optional_data.user_id,
                 personal_data_store.optional_data.id "ObjectID",
                 personal_data_store.optional_data.value "ObjectValue",
                 personal_data_store.optional_data.key "Key",
                 CONCAT(personal_data_store.optional_data.scope) as "ObjectType",
                 personal_data_store.optional_data.created_at "event"
            FROM  personal_data_store.optional_data
            UNION
            SELECT
                 opd.pops_data_replica.user_id,
                 opd.pops_data_replica.id "ObjectID",
                 opd.pops_data_replica.value "ObjectValue",
                 opd.pops_data_replica.key "Key",
                 CONCAT(opd.pops_data_replica.scope) as "ObjectType",
                 opd.pops_data_replica.created_at "event"
            FROM  opd.pops_data_replica
            ORDER BY user_id, event
       ;;
      indexes: ["event"]
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
#example time measure SAM
  measure: activated_account {
    label: "Sign Up Activities - Activation (Measure)"
    type: date_time
    sql:
    CASE
    WHEN ${object_type} = "status change" AND ${object_value} = "completed_activation" THEN MAX(${object_accessed_date_time})
    ELSE NULL
    END;;
  }

  measure: invitation_sent_timestamp {
    label: "Sign Up Activities - Invitation Sent (Measure)"
    type: date_time
    sql:
    CASE
    WHEN ${object_type} = "status change" AND ${object_value} = "invitation_sent" THEN MAX(${object_accessed_date_time})
    ELSE NULL
    END;;
  }



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

#'completed_activation

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


  dimension: object_key {
    label: "Sign Up Activities - Key"
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: object_value {
    label: "Sign Up Activities - Value"
    type: string
    sql: REPLACE(${TABLE}.ObjectValue,'"', '') ;;
  }

#GENDER
  dimension: gender_raw {
    sql: CASE WHEN INSTR(LCASE(${object_key}), "gender") > 0 THEN (${object_value})
          ELSE NULL
          END;;
  }

  dimension: gender_formatted {
    sql:
    CASE
      WHEN ${object_key} = "gender-m-f-p" AND ${gender_raw} = 1 THEN "Male"
      WHEN ${object_key} = "gender-m-f-p" AND ${gender_raw} = 2 THEN "Female"
      WHEN ${object_key} = "gender-m-f-p" AND ${gender_raw} = 3 THEN "Prefer not to say"
      WHEN ${object_key} = "gender-duk" AND ${gender_raw} = "Male" THEN "Male"
      WHEN ${object_key} = "gender-duk" AND ${gender_raw} = "Female" THEN "Female"
      WHEN ${object_key} = "gender-m-f-i-p" AND ${gender_raw} = 0 THEN "Male"
      WHEN ${object_key} = "gender-m-f-i-p" AND ${gender_raw} = 1 THEN "Female"
      WHEN ${object_key} = "gender-m-f-i-p" AND ${gender_raw} = 2 THEN "Intersex"
      WHEN ${object_key} = "gender-m-f-i-p" AND ${gender_raw} = 3 THEN "Prefer not to say"
    ELSE
      "Not Known"
    END;;
  }



#ETHNICITY
  dimension: ethnicity_raw {
    sql: CASE WHEN INSTR(LCASE(${object_key}), "ethnic") > 0 THEN (${object_value})
          ELSE NULL
          END;;
  }

  dimension: ethnicity_formatted {
    sql:
    CASE
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 1 THEN "White - British"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 2 THEN "White - Irish"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 3 THEN "Any other white background"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 4 THEN "Mixed - White and Black Caribbean"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 5 THEN "Mixed - White and Black African"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 6 THEN "Mixed - White and Asian"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 7 THEN "Any other mixed background"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 8 THEN "Asian - Indian"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 9 THEN "Asian - Pakistani"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 10 THEN "Asian - Bangladeshi"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 11 THEN "Any other Asian background"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 12 THEN "Black or Black British - Caribbean"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 13 THEN "Black or Black British - African"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 14 THEN "Any other Black background"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 15 THEN "Any other"
      WHEN ${object_key} = "ethnicity" AND ${ethnicity_raw} = 16 THEN "Prefer not to say"

      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 1 THEN "White - British"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 2 THEN "White - Irish"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 3 THEN "Any other white background"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 4 THEN "Mixed - White and Black Caribbean"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 5 THEN "Mixed - White and Black African"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 6 THEN "Mixed - White and Asian"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 7 THEN "Any other mixed background"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 8 THEN "Asian - Indian"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 9 THEN "Asian - Pakistani"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 10 THEN "Asian - Bangladeshi"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 11 THEN "Black or Black British - Caribbean"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 12 THEN "Black or Black British - African"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 13 THEN "Any other Black background"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 14 THEN "Any other"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 15 THEN "Prefer not to say"
      WHEN ${object_key} = "ethnicity-healthy-living" AND ${ethnicity_raw} = 16 THEN "Any other Asian background"

      WHEN ${object_key} = "ethnic-background-duk" AND ${ethnicity_raw} = "South Asian" THEN "South Asian"
      WHEN ${object_key} = "ethnic-background-duk" AND ${ethnicity_raw} = "Black" THEN "Black"
      WHEN ${object_key} = "ethnic-background-duk" AND ${ethnicity_raw} = "Chinease" THEN "Chinease"
      WHEN ${object_key} = "ethnic-background-duk" AND ${ethnicity_raw} = "Mixed Ethnicity" THEN "Mixed Ethnicity"
      WHEN ${object_key} = "ethnic-background-duk" AND ${ethnicity_raw} = "White" THEN "White"
      WHEN ${object_key} = "ethnic-background-duk" AND ${ethnicity_raw} = "None of these" THEN "None of these"

    ELSE
      "Not Known"
    END;;
  }


#POSTCODE CONVERSION AND FORMATTING
  dimension: postcode_raw {
    hidden: yes
    sql: CASE WHEN (${object_type} = "pops-address" OR ${object_type} = "opt-address" OR ${object_type} = "address")    THEN (${TABLE}.ObjectValue)
          ELSE NULL
          END;;
  }

  dimension: postcode_object {
    hidden: yes
    label: "Sign Up Activities - Postcode"
    type: string
    sql: UCASE(LEFT(REPLACE(REPLACE(${postcode_raw},'"', ''),' ',''),2))
    ;;
  }

  dimension: postcode_location {
    label: "Postcode Area"
    description: "Postcode area (eg. NG for Nottingham) for mapping to postcode area."
    type: string
    map_layer_name: uk_postcode_areas
    sql:
    CASE
    WHEN LEFT(${postcode_object}, 1) REGEXP '^[0-9]+$' THEN NULL
    WHEN RIGHT(${postcode_object}, 1) REGEXP '^[0-9]+$' THEN LEFT(${postcode_object}, 1)
    ELSE ${postcode_object}
    END;;
  }

  dimension: postcode_formatted {
    hidden: yes
    label: "Postcode Formatted"
    sql:  UPPER(${postcode_raw})
    ;;
  ###  sql: INSERT PARCING SQL HERE
  #
  }


  dimension: postcode_formatted_concat {
    label: "Postcode Formatted"
    description: "Postcode data from POPS tables, with correct formatting. These postcodes have not been validated."
    sql:
    CASE WHEN LENGTH(${postcode_formatted}) > 4 THEN CONCAT(LEFT(REPLACE(${postcode_formatted},'.',' '),
                    LENGTH(REPLACE(${postcode_formatted},' ','')) - 3),
                     ' ', -- this will give us that elusive space
                      RIGHT(REPLACE(${postcode_formatted},' ',''), 3))
    ELSE
    ${postcode_formatted}
    END;;
  }

#  dimension: gender_formatted {
#    label: "Postcode Formatted"
#    sql:  UPPER(${postcode_raw})
#      ;;
#    ###  sql: INSERT PARCING SQL HERE
#    #
#  }



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
    group_label: "Signup Activity Time Measures - Creation to Activity"
    label: "between Account Creation and Signup Activity"
    description: "When used with CHUID, shows amount of time between this activity and the users account creation"
    type: duration
    intervals: [day, week, month, hour,minute,second]
    sql_start: ${users.created_raw} ;;
    sql_end: ${signup_event_raw} ;;
  }



  set: detail {
    fields: [
      users.ppuid,
    ]
  }

  set: timeframes {}
}
