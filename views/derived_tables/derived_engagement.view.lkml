view: derived_engagement_12m {

    derived_table: {
      explore_source: users {
        column: ppuid {}
        filters: {
          field: derived_activity_2.months_since_account_creation
          value: "6"
        }
      }
    }
    dimension: ppuid {
      primary_key: yes
      label: "Users Active at 6 Months"
      description: "User was active at 6 month mark"
    }

  dimension: engaged_6m {
    type: yesno
    sql: CASE
    WHEN LENGTH(${ppuid}) > 0 THEN TRUE
    ELSE FALSE
    END;;
    }


  measure: count {
    type: count
    label: "Count - Users Active at 6 Months"
    description: "Was user active at 6 month mark?"
  }

  measure: percent {
    type: percent_of_total
    label: "Percent - Users Active at 6 Months"
    sql: ${count} ;;
    description: "Was user active at 6 month mark?"
  }

}
