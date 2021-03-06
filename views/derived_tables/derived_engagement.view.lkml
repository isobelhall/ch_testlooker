view: derived_engagement_6m {

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
      hidden: yes
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


#  measure: count {
#    type: count
#    label: "Count - Users Active at 6 Months"
#    description: "Was user active at 6 month mark?"
#  }

#  measure: percent {
#    type: percent_of_total
#    label: "Percent - Users Active at 6 Months"
#    sql: ${count} ;;
#    description: "Was user active at 6 month mark?"
#  }

}


view: derived_engagement_3m {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      filters: {
        field: derived_activity_2.months_since_account_creation
        value: "3"
      }
    }
  }
  dimension: ppuid {
    hidden: yes
    primary_key: yes
    label: "Users Active at 3 Months"
    description: "User was active at 3 month mark"
  }

  dimension: engaged_3m {
    type: yesno
    sql: CASE
          WHEN LENGTH(${ppuid}) > 0 THEN TRUE
          ELSE FALSE
          END;;
  }

}
