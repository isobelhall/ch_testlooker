view: fit_tracks {
  sql_table_name: step.fit_tracks ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: activity {
    group_label: "Step Tracker Data"
    label: "Fit Track Type"
    type: string
    sql: ${TABLE}.activity ;;
  }

  dimension_group: created {
    group_label: "Step Tracker Data"
    label: "Fit Track Recorded"
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

  dimension: hit_target {
    group_label: "Step Tracker Data"
    label: "Fit Track Hit Target"
    type: yesno
    sql: ${TABLE}.hit_target ;;
  }

  dimension: logging_steps {
    group_label: "Step Tracker Data"
    label: "Fit Track Steps"
    type: number
    sql: ${TABLE}.logging_steps ;;
  }

  measure: sum_logging_steps {
    group_label: "Step Tracker Data"
    label: "Count - Steps Recorded"
    type: sum
    sql: ${TABLE}.logging_steps ;;
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
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    group_label: "Step Tracker Data"
    label: "Count - Fit Track"
    type: count
    drill_fields: [id]
  }
}
