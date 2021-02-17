view: goals {
  sql_table_name: plugin_goal.goals ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: completed {
    group_label: "Goal Data"
    view_label: "7. Activity Data"
    label: "Goal Completion Date"
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
    sql: ${TABLE}.completed_at ;;
  }

  dimension: goal_completed {
    label: "Goal Completed"
    type: yesno
    sql: CASE WHEN ${completed_date} IS NOT NULL THEN TRUE
    ELSE FALSE END ;;
  }

  dimension_group: created {
    group_label: "Goal Data"
    view_label: "7. Activity Data"
    label: "Goal Creation Date"
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

  dimension: profile_id {
    hidden: yes
    type: number
    sql: ${TABLE}.profile_id ;;
  }

  dimension: program_id {
    hidden: yes
    type: number
    sql: ${TABLE}.program_id ;;
  }

  dimension_group: goal_updated {
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

  dimension: goal_has_been_completed {
    group_label: "Goal Data"
    label: "Goal Was Updated"
    type: yesno
    sql: CASE WHEN ${goal_updated_raw} IS NOT NULL AND ${goal_updated_date} > ${created_date} THEN TRUE
      ELSE FALSE END ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    group_label: "Goal Data"
    label: "Count - Goals"
    type: count
    drill_fields: [id, profiles.id, profiles.name, users.id, answers.count]
  }
}
