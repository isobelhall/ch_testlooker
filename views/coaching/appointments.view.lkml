view: appointments {
  sql_table_name: coaching.appointments ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: api_id {
    hidden: yes
    type: string
    sql: ${TABLE}.api_id ;;
  }

  dimension: cancelled {
    label: "Appointment Was Cancelled"
    type: yesno
    sql: ${TABLE}.cancelled ;;
  }

  dimension: coach_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coach_id ;;
  }

  dimension_group: created {
    label: "Appointment Created"
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

  dimension: created_by {
    hidden: yes
    type: number
    sql: ${TABLE}.created_by ;;
  }

  dimension: created_type {
    hidden: yes
    type: string
    sql: ${TABLE}.created_type ;;
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: message {
    hidden: yes
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: notes {
    hidden: yes
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: program_id {
    hidden: yes
    type: number
    sql: ${TABLE}.program_id ;;
  }

  dimension: result {
    label: "Appointment Outcome"
    #PROBLEM: Map outcomes (1,2,3) to string value (attended, missed, not recorded)
    type: number
    sql: ${TABLE}.result ;;
  }

  dimension_group: since {
    label: "Appointment Start"
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
    sql: ${TABLE}.since ;;
  }

  dimension: timedata {
    #PROBLEM: Derive length of appointment. Either calculate difference between 'since' and 'to' or derive from this string
    hidden: yes
    type: string
    sql: ${TABLE}.timedata ;;
  }

  dimension_group: to {
    label: "Appointment Finish"
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
    sql: ${TABLE}.`to` ;;
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

  dimension: updated_by {
    hidden: yes
    type: number
    sql: ${TABLE}.updated_by ;;
  }

  dimension: updated_type {
    hidden: yes
    type: string
    sql: ${TABLE}.updated_type ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Appointment Count"
    type: count
    drill_fields: [id, users.id]
  }
}
