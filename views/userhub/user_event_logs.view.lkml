view: user_event_logs {
  sql_table_name: userhub.user_event_logs ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    label: "User Account Events"
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: event_type {
    view_label: "1. User Account"
    label: "System Status"
    type: string
    sql: ${TABLE}.event_type ;;
  }

  #to fix 'enabled' issue, filter bye event type representing activated.

  dimension: payload {
    hidden: yes
    type: string
    sql: ${TABLE}.payload ;;
  }

  dimension: program_id {
    hidden: yes
    type: number
    sql: ${TABLE}.program_id ;;
  }

  dimension_group: updated {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Count - User Events"
    type: count
    drill_fields: [id, users.id]
  }
}
