view: plugins_accessed {
  sql_table_name: program.plugins_accessed ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    group_label: "Plugin Data"
    view_label: "7. Activity Data"
    label: "Plugin Accessed Date"
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

  dimension: plugin_id {
    type: number
    hidden: yes
    sql: ${TABLE}.plugin_id ;;
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
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    group_label: "Plugin Data"
    label: "Count - Plugins Accessed"
    type: count
    drill_fields: [id, users.id, coaching_plugins.id]
  }
}
