view: derived_engagement_12m {

    derived_table: {
      explore_source: users {
        column: ppuid {}
        filters: {
          field: derived_activity_2.months_since_account_creation
          value: "12"
        }
      }
    }
    dimension: ppuid {
      primary_key: yes
      label: "Users Active at 12 Months"
      description: "User was active at 12 month mark"
    }


  dimension: engaged_12m {
    type: yesno
    sql:
    CASE
    WHEN ${ppuid} IS NULL THEN 'No'
    ELSE 'Yes'
    END ;;
    }


  measure: count {
    type: count
    label: "Count - Users Active at 12 Months"
    description: "Was user active at 12 month mark?"
  }

}
