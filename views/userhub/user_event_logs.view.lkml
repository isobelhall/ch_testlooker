view: user_event_logs {
  sql_table_name: userhub.user_event_logs ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    label: "User Account Events"
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

  #@ISOBEL 6 measures required, 3 date, 3 yesno
 #measure for SQL: yesno where count of invitation, activation, deletion > 0

  dimension: event_type {
    view_label: "1. User Account"
    label: "System Status"
    type: string
    hidden: yes
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_system_status {
    view_label: "1. User Account"
    label: "System Account Status"
    type: string
    case: {
      when: {
        sql: ${event_type} = 'invitation_sent' ;;
        label: "Referred - Invitation Sent"
      }
      when: {
        sql: ${event_type} = 'completed_activation'  ;;
        label: "Active - Completed Activation"
      }
      when: {
        sql: ${event_type} = 'user_deleted' ;;
        label: "User Deleted - User Activated Deletion"
      }
    }
  }


  #to fix 'enabled' issue, filter by event type representing activated.

  dimension: payload {
    hidden: yes
    type: string
    sql: ${TABLE}.payload ;;
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
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    hidden: yes
    label: "Count - User Events"
    type: count
    drill_fields: [id, users.id]
  }
}
