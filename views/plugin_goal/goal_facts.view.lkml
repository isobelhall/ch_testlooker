view: goal_facts {


  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: count { field: goals.count }
      column: count_goal_completed {field: goals.count_hit_target}
      column: count_goals_updated {field: goals.count_goals_updated}
    }
  }
  dimension: ppuid {
    primary_key: yes
    hidden: yes
    description: "Platform identifier for each participant"
  }

  measure: count_ppts_with_goals {
    label: "Count - Participants with goals"
    type: count
    drill_fields: [users.ppuid]
  }

  dimension: count {
    hidden: yes
    label: "Count - Goals Tracked"
    type: number
  }

  dimension: has_set_goal {
    label: "User has set a goal"
    description: "Has this user set at least one goal on the goals plugin?"
    type: yesno
    sql:
    CASE WHEN ${count} > 0 THEN TRUE
    ELSE FALSE
    END;;
    drill_fields: [users.ppuid]
  }

  measure: count_users_set_goals{
    label: "Counts - Users that have completed goals"
    type: count
    filters: [has_set_goal: "Yes"]
  }

  dimension: count_goal_completed {
    label: "Count - Times Goal Completed"
    type: number
    drill_fields: [users.ppuid]
  }

  dimension: user_has_completed_goals {
    label: "User has completed a goal"
    description: "Has this user completed any goals?"
    type: yesno
    sql:
    CASE WHEN ${count_goal_completed} > 0 THEN TRUE
    ELSE FALSE
    END;;
    drill_fields: [users.ppuid]
  }

  measure: count_users_completed_goals {
    label: "Counts - Users that have completed goals"
    type: count_distinct
    filters: [user_has_completed_goals: "Yes"]
  }

  dimension: count_goals_updated {
    label: "Count - Times Goals Updated"
    type: number
    drill_fields: [users.ppuid]
  }

  dimension: user_has_updated_goals {
    label: "User has updated a goal"
    description: "Has this user updated any goals?"
    type: yesno
    sql:
    CASE WHEN ${count_goals_updated} > 0 THEN TRUE
    ELSE FALSE
    END;;
    drill_fields: [users.ppuid]
  }

measure: count_users_updated_goals {
  label: "Counts - Users that have updated goals"
  type: count_distinct
  filters: [user_has_updated_goals: "Yes"]
}

 }
