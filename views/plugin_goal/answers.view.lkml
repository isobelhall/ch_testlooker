view: answers {
  sql_table_name: plugin_goal.answers ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
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

  dimension: goal_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.goal_id ;;
  }

  dimension: multiple {
    hidden: yes
    type: yesno
    sql: ${TABLE}.multiple ;;
  }

  dimension: token {
    hidden: yes
    type: string
    sql: ${TABLE}.token ;;
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

  measure: count {
    type: count
    drill_fields: [id, goals.id]
  }
}
