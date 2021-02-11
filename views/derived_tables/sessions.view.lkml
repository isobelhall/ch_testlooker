view: sessions {
  view_label: "8. Platform Events"
  derived_table: {
    sql:
      SELECT
        session_id,
        MIN(event) as session_start,
        MAX(event) as session_end
      FROM ${derived_activity_2.SQL_TABLE_NAME}
      GROUP BY 1
    ;;
  }
  dimension: session_id {
    hidden: yes
    primary_key:yes
    }

  dimension_group: session_start {
    group_label: "Sessions"
    type: time
    timeframes: [raw, time, date, week, month]
  }
  dimension_group: session_end {
    group_label: "Sessions"
    type: time
    timeframes: [raw, time, date, week, month]
  }
  dimension: session_duration {
    group_label: "Sessions"
    description: "Length of the session in minutes"
    type: duration_minute
    sql_start: ${session_start_raw} ;;
    sql_end: ${session_end_raw} ;;
  }
  measure: average_session_duration {
    group_label: "Sessions"
    description: "In Minutes"
    type: average
    sql: ${session_duration} ;;
  }
  measure: count {
    group_label: "Sessions"
    label: "Count - Engagements per session"
    type: count
    description: "Number of times a participant engaged in each session"
  }

}
