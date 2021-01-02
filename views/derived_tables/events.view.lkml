#Attempt to copy the code from the testing team to create derived table with time difference and sessions

view: events {
  view_label: "8. Platform Events"
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
        TIMESTAMPDIFF(MINUTE,lag(event) over (partition by user_id order by event), event) as `mins_since_last_event`
        FROM (
          SELECT
                concat(id, "-", "article_access") as `pk`,
                user_id,
                created_at  AS `event`,
                "article_access" as `type`
              FROM article.articles_accessed
              UNION ALL
              SELECT
                concat(id, "-", "weight_track") as `pk`,
                user_id,
                created_at  AS `event`,
                "weight_track" as `type`
              FROM plugin_weight.weight_tracks
              UNION ALL
              SELECT
                concat(id, "-", "food_tracks") as `pk`,
                user_id,
                created_at  AS `event`,
                "food_tracks" as `type`
              FROM plugin_food.food_tracks
              SELECT
                concat(id, "-", "fit_tracks") as `pk`,
                user_id,
                created_at  AS `event`,
                "fit_tracks" as `type`
              FROM step.fit_tracks
            ) as events ) as events_lag
            ) events_session_flag
       ;;
  }

  measure: count {
    label: "Count - Platform Use"
    type: count
    drill_fields: [detail*]
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
    #label: ""
    type: time
    timeframes: [raw,time,date,week,month]
    sql: ${TABLE}.event ;;
  }

  dimension_group: since_account_creation {
    type: duration
    intervals: [day, week, month]
    sql_start: ${users.created_raw} ;;
    sql_end: ${event_raw} ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: mins_since_last_event {
    #hidden: yes
    type: number
    sql: ${TABLE}.mins_since_last_event ;;
  }

  dimension: is_new_session {
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
    view_label: "Sessions"
    description: "Is this the user's 1st session, or their 3rd, etc."
    type: number
    sql: ${TABLE}.user_session_sequence ;;
  }

  set: detail {
    fields: [
      pk,
      user_id,
      event_time,
      type,
      mins_since_last_event,
      is_new_session,
      session_id,
      user_session_sequence
    ]
  }
}
