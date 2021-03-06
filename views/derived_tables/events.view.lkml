#Attempt to copy the code from the testing team to create derived table with time difference and sessions

view: events {
  view_label: "8. Platform Events"
  derived_table: {
    #ISOBEL: ADD IN ALL PLATFORM USAGE (EG, PLUGINS, GOALS) BUT NOT APPOINTMENTS OR TELEPHONE CALLS
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
                id as `pk`,
                user_id,
                created_at  AS `event`
              FROM article.articles_accessed
              UNION ALL
              SELECT
                id as `pk`,
                user_id,
                created_at  AS `event`
              FROM program.plugins_accessed
              UNION ALL
              SELECT
                id as `pk`,
                user_id,
                created_at  AS `event`
              FROM plugin_weight.weight_tracks
              UNION ALL
              SELECT
                id as `pk`,
                user_id,
                created_at  AS `event`
              FROM plugin_food.food_tracks
              UNION ALL
              SELECT
                id as `pk`,
                user_id,
                created_at  AS `event`
              FROM step.fit_tracks
              UNION ALL
              SELECT
                id as `pk`,
                user_id,
                created_at  AS `event`
              FROM plugin_goal.goals
            ) as events ) as events_lag
            ) events_session_flag
       ;;
  }

#  LINE 26              "article_access" as `type`
# TYPE removed from above script, eg,                 "goals" as `type`, under 'created_at...'

  measure: count {
    label: "Count - Platform Use"
    type: count
    drill_fields: [detail*]
  }

  measure: count_users {
    label: "Count - Users with tracked events"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [detail*]
  }

  measure: count_events {
    label: "Count - Events"
    type: count_distinct
    sql: ${pk} ;;
  }

  measure: activities_per_user {
    type:  number
    value_format: "0.##"
    sql: ${count_events} / ${count_users} ;;
  }

  measure: last_events{
    label: "Last Event"
    type: date
    sql: MAX(${event_date})  ;;
  }


  dimension: pk {
    #hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.pk ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: event {
    hidden: yes
    #label: ""
    type: time
    timeframes: [raw,time,date,week,month, hour_of_day, day_of_week,day_of_month]
    sql: ${TABLE}.event ;;
  }

  dimension_group: since_account_creation {
    label: "Since Account Creation"
    type: duration
    intervals: [day, week, month, hour]
    sql_start: ${users.created_raw} ;;
    sql_end: ${event_raw} ;;
  }

#added 12/01 SL
  dimension: mnth_since_last_event {
    label: "Months Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.mnth_since_last_event ;;
  }
#added 12/01 SL
  dimension: week_since_last_event {
    label: "Weeks Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.week_since_last_event ;;
  }
#added 12/01 SL
  dimension: days_since_last_event {
    label: "Days Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.days_since_last_event ;;
  }

  dimension: mins_since_last_event {
    label: "Mins Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.mins_since_last_event ;;
  }

#added 12/01 SL
  dimension: secs_since_last_event {
    label: "Seconds Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.secs_since_last_event ;;
  }

  measure: sum_secs_since_last_event {
    label: "Count - Seconds Since Previous Event"
    #hidden: yes
    type: sum
    drill_fields: [detail*]
    sql: ${TABLE}.secs_since_last_event ;;
  }

  measure: sum_derived_mins_since_last_event {
    label: "Count - Minutes Since Previous Event"
    #hidden: yes
    type: sum
    drill_fields: [detail*]
    sql: ROUND(${TABLE}.secs_since_last_event / 60, 1) ;;
  }

  measure: sum_derived_mins_since_last_event_per_user{
    label: "Average - Minutes Since Previous Event, Per User"
    #hidden: yes
    type: number
    value_format: "0.##"
    drill_fields: [detail*]
    sql: ${sum_derived_mins_since_last_event} / ${count_users} ;;
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

  measure: max {
    label: "Maximum session count"
    type: max
    sql: ${TABLE}.user_session_sequence ;;
    description: "Highest session count by this participant"
  }

  measure: max2 {
    label: "Maximum2 session count"
    type: max
    sql: ${TABLE}.sessions ;;
    description: "Highest session count by this participant"
  }

  measure: average_session {
    label: "Average session count"
    type: average
    sql: ${TABLE}.user_session_sequence ;;
    description: "Highest session count by this participant"
  }

  set: detail {
    fields: [
      user_id,
      event_time,
      mins_since_last_event,
      is_new_session,
      session_id,
      user_session_sequence
    ]
  }
}
