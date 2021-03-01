view: progress_statistics {
  sql_table_name: program.progress_statistics ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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

  dimension: program_id {
    hidden: yes
    type: number
    sql: ${TABLE}.program_id ;;
  }

  dimension: progress {
    label: "Progress Percent"
    type: number
    sql: ${TABLE}.progress ;;
  }

  dimension: progress_tier {
    type: tier
    tiers: [0,25,50,75,90]
    style: integer
    sql: ${progress} ;;
  }

  dimension_group: updated {
    label: "Progress Updated"
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
    label: "Progress Count"
    type: count
    drill_fields: [id, users.id]
  }
}
