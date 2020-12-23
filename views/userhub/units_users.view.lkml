view: units_users {
  sql_table_name: userhub.units_users ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: connected {
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
    sql: ${TABLE}.connected_at ;;
  }

  dimension_group: created {
    label: "Status Created"
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

  dimension_group: deleted {
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
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: role {
    hidden: yes
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: status {
    label: "Account Programme Status"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: unit_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.unit_id ;;
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
    hidden: yes
    type: count
    drill_fields: [id, users.id, units.id, units.name, units.display_name]
  }
}
