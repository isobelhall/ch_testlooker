view: sessions {
  view_label: "8. Platform Events"
  derived_table: {
    sql:
      SELECT
        session_id,
        MIN(event) as session_start,
        MAX(event) as session_end
      FROM ${events.SQL_TABLE_NAME}
      GROUP BY 1
    ;;
  }
  dimension: session_id {primary_key:yes}
  dimension_group: session_start {
    type: time
    timeframes: [raw, time, date, week, month]
  }
  dimension_group: session_end {
    type: time
    timeframes: [raw, time, date, week, month]
  }
  dimension: session_duration {
    description: "Length of the session in minutes"
    type: duration_minute
    sql_start: ${session_start_raw} ;;
    sql_end: ${session_end_raw} ;;
  }
  measure: average_session_duration {
    description: "In Minutes"
    type: average
    sql: ${session_duration} ;;
  }
  measure: count {
    label: "Count - Engagements per session"
    type: count
    description: "Number of times a participant engaged in each session"
  }

  measure: max {
    label: "Maximum session count"
    type: max
    sql: ${TABLE}.user_session_sequence ;;
    description: "Highest session count by this participant"
  }

  measure: average_session {
    label: "Average session count"
    type: average
    sql: ${TABLE}.user_session_sequence ;;
    description: "Highest session count by this participant"
  }

}
