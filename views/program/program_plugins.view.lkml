view: program_plugins {
  sql_table_name: program.plugins ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: icon_text {
    type: string
    sql: ${TABLE}.icon_text ;;
  }

  dimension: locked_message {
    type: string
    sql: ${TABLE}.locked_message ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: optional {
    type: string
    sql: ${TABLE}.optional ;;
  }

  dimension: system_name {
    label: "Plugin Name"
    type: string
    sql: ${TABLE}.system_name ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: translations {
    type: string
    sql: ${TABLE}.translations ;;
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

  dimension: webmethod {
    type: string
    sql: ${TABLE}.webmethod ;;
  }

  measure: count {
    type: count
    drill_fields: [id, system_name, display_name, users.id]
  }
}
