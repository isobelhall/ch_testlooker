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


  dimension: engaged_12m {
    type: yesno
    sql:
    CASE
    WHEN LEN(${ppuid}) > 0 THEN 'Yes'
    ELSE 'No'
    END ;;
    }


  measure: count {
    type: count
    label: "Count - Users Active at 6 Months"
    description: "Was user active at 6 month mark?"
  }

}
