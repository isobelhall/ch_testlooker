view: goals {
  sql_table_name: plugin_goal.goals ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: completed {
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


  dimension_group: created {
    label: "Goal Creation Date"
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      hour_of_day,
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

  measure: count {
    label: "Count - Goals Tracked"
    type: count
    drill_fields: [id, users.ppuid]
  }

  measure: percent {
    label: "Percent of Total  - Goals Tracked"
    type: percent_of_total
    sql: ${count} ;;
    drill_fields: [id, users.ppuid]
    value_format: "0.0\%"
  }

  dimension: goal_completed {
    label: "Goal Completed"
    type: yesno
    sql:
      CASE WHEN ${completed_date} IS NOT NULL THEN TRUE
      ELSE FALSE END ;;
    drill_fields: [id, users.ppuid]
    }

  measure: count_hit_target {
    label: "Count - Goals hit"
    type: count
    filters: [goal_completed: "Yes"]
    drill_fields: [id, users.ppuid, profiles.name]
  }

  dimension: goal_has_been_updated {
    label: "Goal Was Updated"
    type: yesno
    sql: CASE WHEN ${goal_updated_raw} IS NOT NULL AND ${goal_updated_date} > ${created_date} THEN TRUE
      ELSE FALSE END ;;
  }

  measure: count_goals_updated {
    label: "Count - Goals hit"
    hidden: yes
    type: count
    filters: [goal_has_been_updated: "Yes"]
    drill_fields: [id, users.ppuid, profiles.name]
  }


#MEASURES/DIMENSIONS FOR IF USER HAS HIT A WEIGHT TARGET,
#Weight Tracking Plugin Weight Goal
#Steps Plugin Daily Steps Goal
  #  dimension:  {

  #  }
}
