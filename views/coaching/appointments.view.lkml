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
    label: "Appointment Outcome (Code)"
    #PROBLEM: Map outcomes (1,2,3) to string value (attended, missed, not recorded)
    type: number
    sql: ${TABLE}.result ;;
  }

  dimension: result_english {
    label: "Appointment Outcome"
    description: "Appointment outcome as Complete (attended/successful appointment),     Missed (call did not take place as participant didn't answer) or Rescheduled (call did not take place but has been re-arranged)"
    #Map outcomes (1,2,3) to string value (attended, missed, not recorded)
    type: string
    case: {
      when: {
        sql:  ${TABLE}.result = 1;;
        label: "No Answer"
        }
      when: {
          sql: ${TABLE}.result = 2 ;;
          label: "Rescheduled"
        }
      when: {
          sql: ${TABLE}.result = 3 ;;
          label: "Complete"
        }
      else: "Not Recorded"
      }
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
    label: "Count - Appointments"
    type: count
    drill_fields: [id, users.id]
  }

  measure: count_attended {
    type: count
    label: "Count - Appointments Attended"
    filters: [result: "3", cancelled: "No"]
  }

  measure: average_attended {
    type: average
    label: "Average - Appointments Attended"
    filters: [result: "3", cancelled: "No"]
  }

  measure: count_cancelled {
    label: "Count - Appointments Cancelled"
    type: count
    filters: [cancelled: "Yes"]
  }

  measure: percent_attended {
    label: "Count - Percent Appointments Attended"
    type: number
    value_format_name: percent_1
    sql: 1.0*${count_attended}/nullif(${count},0) ;;
  }

}
