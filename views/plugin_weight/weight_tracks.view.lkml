view: weight_tracks {
  sql_table_name: plugin_weight.weight_tracks ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    label: "Weight Recorded"
    #hidden: yes
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

  dimension: hit_half_target {
    hidden: yes
    type: yesno
    sql: ${TABLE}.hit_half_target ;;
  }

  dimension: hit_target {
    label: "Did this weight meet weight target?"
    type: yesno
    sql: ${TABLE}.hit_target ;;
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
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: weight_goal {
    label: "Weight Recorded Value"
    type: number
    sql: ${TABLE}.weight_goal ;;
  }


  measure: average {
    label: "Average - Recorded Weight"
    type: average
    sql: ${TABLE}.weight_goal ;;
    drill_fields: [id, users.ppuid]
  }

  measure: count {
    label: "Count - Weights Tracked"
    type: count
    drill_fields: [id, users.ppuid]
  }

  measure: count_hit_target {
    label: "Count - Times Weight Target Hit"
    type: count
  filters: [hit_target: "Yes"]
    drill_fields: [id, users.ppuid]
  }

}
