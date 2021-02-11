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
    group_label: "Plugin Data"
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

  dimension: description {
    group_label: "Plugin Data"
    hidden: yes
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: display_name {
    group_label: "Plugin Data"
    label: "Plugin Name"
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: system_name {
    label: "Plugin Name"
    description: "Name of plugin accessed"
    type: string
    sql: ${TABLE}.system_name ;;
  }

  dimension: icon_text {
    group_label: "Plugin Data"
    hidden: yes
    type: string
    sql: ${TABLE}.icon_text ;;
  }

  dimension: locked_message {
    group_label: "Plugin Data"
    hidden: yes
    type: string
    sql: ${TABLE}.locked_message ;;
  }

  dimension: message {
    group_label: "Plugin Data"
    hidden: yes
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: optional {
    group_label: "Plugin Data"
    hidden: yes
    type: string
    sql: ${TABLE}.optional ;;
  }



  dimension: title {
    group_label: "Plugin Data"
    hidden: yes
    description: "Plugin locked or not"
    label: "Plugin Title"
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: translations {
    group_label: "Plugin Data"
    hidden: yes
    type: string
    sql: ${TABLE}.translations ;;
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

  dimension: webmethod {
    hidden: yes
    type: string
    sql: ${TABLE}.webmethod ;;
  }

  measure: count {
    group_label: "Plugin Data"
    hidden: yes
    label: "Count - Plugins In Platform"
    type: count
    drill_fields: [id, system_name, display_name, users.id]
  }
}
