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
    group_label: "Weight Data"
    view_label: "7. Activity Data"
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
    group_label: "Weight Data"
    label: "Did this weight meet weight target?"
    type: yesno
    sql: ${TABLE}.hit_target ;;
  }

  dimension_group: updated {
    label: "Weight Recorded"
    group_label: "Weight Data"
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
    group_label: "Weight Data"
    view_label: "7. Activity Data"
    label: "Weight Recorded Value"
    type: number
    sql: ${TABLE}.weight_goal ;;
  }


  measure: average {
    group_label: "Weight Data"
    label: "Average - Recorded Weight"
    type: average
    sql: ${TABLE}.weight_goal ;;
    drill_fields: [id, users.id]
  }

  measure: count {
    group_label: "Weight Data"
    label: "Count - Weights Tracked"
    type: count
    drill_fields: [id, users.id]
  }



}
