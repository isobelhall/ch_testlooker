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
      time_of_day,
      hour_of_day,
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


  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      time_of_day,
      hour_of_day,
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

  # When a user records their weight
  dimension: weight_goal {
    label: "Weight Recorded Value"
    type: number
    sql: ${TABLE}.weight_goal ;;
  }

#MEASURES/DIMENSIONS FOR IF USER HAS HIT A WEIGHT TARGET
  dimension: hit_target {
    label: "Weight Measurement meets weight target?"
    type: yesno
    sql: ${TABLE}.hit_target ;;
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

  measure: percent {
    label: "Percent of Total  - Weights Tracked"
    type: percent_of_total
    sql: ${count} ;;
    drill_fields: [id, users.ppuid]
    value_format: "0.0\%"
  }


  measure: count_hit_target {
    label: "Count - Times Weight Target Hit"
    type: count
    filters: [hit_target: "Yes"]
    drill_fields: [id, users.ppuid]
  }

}
