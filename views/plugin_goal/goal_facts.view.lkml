view: goal_facts {

    derived_table: {
      explore_source: users {
        column: name { field: profiles.name }
        column: count2 {}
        column: ppuid {}
      }
    }
    dimension: name {
      hidden: yes
    }
    dimension: count2 {
      hidden: yes
      label: "0. General Count - Participants"
      description: "Count of all participants against other selected criteria"
      type: number
    }
    dimension: ppuid {
      label: "1. User Account CHUID"
      description: "Platform identifier for each participant"
    }

    dimension: set_weight_goal {
      label: "Has set weight goal"
      description: "User has set a weight goal. Count of 'Weight Goal' is greater than or equal to 1."
      sql:
      CASE
      ${name} = "Weight Tracking Plugin Weight Goal" AND ${count2} > 0 THEN TRUE
      ELSE FALSE
      END
      ;;
      }

  dimension: set_step_goal {
    label: "Has set step goal"
    description: "User has set a step goal. Count of 'Daily Steps Goal' is greater than or equal to 1."
    sql:
      CASE
      ${name} = "Steps Plugin Daily Steps Goal" AND ${count2} > 0 THEN TRUE
      ELSE FALSE
      END
      ;;
  }
 }
