view: logins {
  sql_table_name: userhub.logins ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    view_label: "1. User Account"
    label: "Login Date"
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

  dimension_group: updated {
    view_label: "1. User Account"
    label: "Account Last Updated"
    type: time
    timeframes: [
      raw, time, date, week, month, quarter, year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    view_label: "1. User Account"
    hidden: yes
    label: "Login User ID"
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: first_login {
    view_label: "1. User Account"
    label: "First Login for This User"
    type: date
    sql: MIN(${created_date}) ;;
  }

  measure: max_login {
    view_label: "1. User Account"
    label: "Latest Login for This User"
    type: date
    sql: Max(${created_date}) ;;
  }

  measure: count {
    view_label: "1. User Account"
    label: "Count - Logins"
    type: count
    drill_fields: [id, users.id, user_id]
  }
}
