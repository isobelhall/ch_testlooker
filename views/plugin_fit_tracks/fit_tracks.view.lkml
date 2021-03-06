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
    label: "Fit Track Type"
    type: string
    sql: ${TABLE}.activity ;;
    drill_fields: [id, users.ppuid]
  }

  dimension_group: created {
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
    drill_fields: [id, users.ppuid]
  }


  dimension: logging_steps {
    label: "Fit Track Steps"
    type: number
    sql: ${TABLE}.logging_steps ;;
    drill_fields: [id, users.ppuid]
  }

  dimension: logged_steps {
    label: "Step count is greater than 0"
    type: yesno
    sql:
    CASE
    WHEN ${logging_steps} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

  measure: sum_has_counted_steps {
    label: "Count users who recorded steps TEST"
    type: sum
    sql: CASE WHEN ${logged_steps} = true THEN 1 ELSE 0 END ;;
  }

  measure: sum_logging_steps {
    label: "Count - Steps Recorded"
    type: sum
    sql: ${TABLE}.logging_steps ;;
    drill_fields: [id, users.ppuid]
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
    drill_fields: [id, users.ppuid]
  }

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Count - Fit Track"
    type: count
    drill_fields: [id, users.ppuid]
  }

  measure: has_counted_steps {
    #hidden so only fit_track_facts measure shows
   # hidden: yes
    label: "Has counted steps?"
    type: yesno
    sql:
    CASE WHEN ${count} > 0 THEN TRUE
    ELSE FALSE
    END;;
    drill_fields: [id, users.ppuid]
  }

#MEASURES/DIMENSIONS FOR IF USER HAS HIT A WEIGHT TARGET
  dimension: hit_target {
    label: "Fit Track Hit Target"
    type: yesno
    sql: ${TABLE}.hit_target ;;
    drill_fields: [id, users.ppuid]
  }

  measure: average {
    label: "Average - Recorded Stepcount"
    type: average
    sql: ${TABLE}.logging_steps ;;
    drill_fields: [id, users.ppuid]
  }


  measure: count_hit_target {
    label: "Count - Times Stepcount Target Hit"
    type: count
    filters: [hit_target: "Yes"]
    drill_fields: [id, users.ppuid]
  }



}
