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
  }

  dimension: count_hit_target {
    hidden: yes
    label: "Count - Hit Weight Target"
    type: number
  }

  dimension: user_has_completed_goals {
    label: "User has completed a goal"
    description: "Has this user completed any goals?"
    type: yesno
    sql:
    CASE WHEN ${count_hit_target} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

  dimension: count_goals_updated {
    hidden: yes
    label: "Count - Goals Updated"
    type: number
  }

  dimension: user_has_updated_goals {
    label: "User has updated a goal"
    description: "Has this user updated any goals?"
    type: yesno
    sql:
    CASE WHEN ${count_goals_updated} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

 }
