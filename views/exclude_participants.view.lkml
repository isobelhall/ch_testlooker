view: exclude_participants {
  sql_table_name: `changing-health-looker-test.missing_tables_07_12_20.Exclude_participants`
    ;;

  dimension: ch_uid {
    type: string
    sql: ${TABLE}.CH_UID ;;
  }

  dimension: email_address {
    type: string
    hidden: yes
    sql: ${TABLE}.Email_address ;;
  }

  dimension: notes {
    hidden: yes
    type: string
    sql: ${TABLE}.Notes ;;
  }

  dimension: partner_unit {
    hidden: yes
    type: string
    sql: ${TABLE}.Partner_Unit ;;
  }

  dimension: reason_for_exclusion {
    hidden: yes
    type: string
    sql: ${TABLE}.Reason_for_Exclusion ;;
  }

  dimension: requester_name {
    hidden: yes
    type: string
    sql: ${TABLE}.Requester_Name ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.Timestamp ;;
  }

  measure: count {
    type: count
    drill_fields: [requester_name]
  }
}
