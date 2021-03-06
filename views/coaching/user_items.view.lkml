view: user_items {
  sql_table_name: coaching.user_items ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: coach_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coach_id ;;
  }

  dimension: comment {
    hidden: yes
    type: string
    sql: ${TABLE}.comment ;;
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

  dimension: item_id {
    label: "Item shared with User"
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.item_id ;;
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
    type: count
    drill_fields: [id, users.id, items.id]
  }
}
