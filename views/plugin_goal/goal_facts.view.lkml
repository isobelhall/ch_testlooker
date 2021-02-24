view: goal_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: count { field: goals.count }
      column: count_hit_target {field: goals.count_hit_target}
      column: count_goals_updated {field: goals.count_goals_updated}
    }
  }
  dimension: ppuid {
    primary_key: yes
    hidden: yes
    description: "Platform identifier for each participant"
  }
  dimension: count {
    hidden: yes
    label: "Count - Weights Tracked"
    type: number
  }

  dimension: count_hit_target {
    hidden: yes
    label: "Count - Hit Weight Target"
    type: number
  }

  dimension: user_has_tracked_goals {
    type: yesno
    sql:
    CASE WHEN ${count} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

  dimension: count_goals_updated {
    hidden: yes
    label: "Count - Hit Goal Targets"
    type: number
  }

  dimension: user_has_updated_goals {
    label: "User has hit a weight target"
    type: yesno
    sql:
    CASE WHEN ${count_goals_updated} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

 }
