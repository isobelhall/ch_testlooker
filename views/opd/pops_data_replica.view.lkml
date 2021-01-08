view: pops_data_replica {
  sql_table_name: opd.pops_data_replica ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    label: "User Characteristic Entered On"
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

  dimension: key {
    type: string
    sql: ${TABLE}.`key` ;;
  }

  dimension: object_id {
    type: string
    sql: ${TABLE}.object_id ;;
  }

  dimension: scope {
    label: "User Characteristics Type"
    type: string
    sql: ${TABLE}.scope ;;
  }

  dimension_group: updated {
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
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: value {
    label: "User Characteristic Value"
    type: string
    sql: ${TABLE}.value ;;
  }

  dimension: visible {
    type: yesno
    sql: ${TABLE}.visible ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.id]
  }
}
