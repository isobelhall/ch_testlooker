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
      hidden: yes
      label: "1. User Account CHUID"
      description: "Platform identifier for each participant"
    }

# goal_facts
    dimension: set_weight_goal {
      type: yesno
      description: "User has set a weight goal. Count of 'Weight Goal' is greater than or equal to 1."
      sql:
      CASE
      WHEN ${name} = "Weight Tracking Plugin Weight Goal" AND ${count2} > 0 THEN 1
      ELSE 0
      END
      ;;
      }


  dimension: set_step_goal {
    type: yesno
    description: "User has set a step goal. Count of 'Daily Steps Goal' is greater than or equal to 1."
    sql:
      CASE
      WHEN ${name} = "Steps Plugin Daily Steps Goal" AND ${count2} > 0 THEN 1
      ELSE 0
      END
      ;;
  }
 }
