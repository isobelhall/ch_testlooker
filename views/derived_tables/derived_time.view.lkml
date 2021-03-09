view: derived_time {

  derived_table: {
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
            ORDER BY user_id, event
            ) as events ) as events_lag
          ) events_session_flag
       ;;
      indexes: ["event"]
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

##calculate average users with activity
#  measure: activites_per_user {
#    label: "Average - Activities per user"
#    description: "Number activities (articles read, weights tracked) divided by number of unique users"
#    type: number
#    sql: ${count} / ${count_users} ;;
#    drill_fields: [detail*]
#  }

  dimension_group: object_accessed_date {
    hidden: yes
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
    label: "Days since latest activity"
    type: number
    sql:DATEDIFF(now(), MAX(${event_raw})) ;;
  }

  dimension_group: since_account_creation {
    label: "between Account Creation and Activity"
    description: "When used with CHUID, shows amount of time between this activity and the users account creation"
    type: duration
    intervals: [day, week, month, hour, minute, second]
    sql_start: ${users.created_raw} ;;
    sql_end: ${event_raw} ;;
  }


#added 12/01 SL
  dimension: mnth_since_last_event {
    label: "5. Months Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.mnth_since_last_event ;;
  }
#added 12/01 SL
  dimension: week_since_last_event {
    label: "4. Weeks Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.week_since_last_event ;;
  }
#added 12/01 SL
  dimension: days_since_last_event {
    label: "3. Days Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.days_since_last_event ;;
  }

  dimension: mins_since_last_event {
    label: "2. Mins Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql: ${TABLE}.mins_since_last_event;;
  }

#  dimension: secs_since_last_event {
#    label: "1. Seconds Since Previous Event"
#    hidden: yes
#    type: number
#    drill_fields: [detail*]
#    sql: ${TABLE}.secs_since_last_event;;
#  }

  dimension: secs_since_last_event {
    label: "1. Seconds Since Previous Event"
    #hidden: yes
    type: number
    drill_fields: [detail*]
    sql:
    CASE WHEN ${TABLE}.secs_since_last_event < 60 THEN (${TABLE}.secs_since_last_event) / 86400.0
    ELSE NULL
    END;;
    value_format: "HH:MM:SS"
  }

  measure: sum_secs_since_last_event {
    label: "Count - Seconds Since Previous Event"
    #hidden: yes
    type: sum
    drill_fields: [detail*]
    sql: ${TABLE}.secs_since_last_event
      ;;
    value_format: "HH:MM:SS"
  }

  measure: sum_derived_mins_since_last_event {
    label: "Count - Minutes Since Previous Event"
    #hidden: yes
    type: sum
    drill_fields: [detail*]
    sql: ROUND(${TABLE}.secs_since_last_event / 60, 1) < 10 ;;
  }

  measure: sum_derived_mins_since_last_event_per_user{
    label: "Average - Minutes Since Previous Event, Per User"
    #hidden: yes
    type: number
    value_format: "0.##"
    drill_fields: [detail*]
    sql: ${sum_derived_mins_since_last_event} / ${count_users} ;;
  }

  measure: sum_derived_mins_since_last_event_per_event {
    label: "Average - Minutes Since Previous Event, Per Event"
    #hidden: yes
    type: number
    value_format: "0.##"
    drill_fields: [detail*]
    sql: ${sum_derived_mins_since_last_event} / ${count} ;;
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
      users.ppuid,
      is_new_session,
      session_id,
      user_session_sequence
    ]
  }


}
