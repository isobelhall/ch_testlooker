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
      hidden: yes
      primary_key: yes
      label: "Users Active at 12 Months"
      description: "User was active at 12 month mark"
    }

  dimension: engaged_12m {
    type: yesno
    label: "Users Active at 12 Months"
    description: "Was user active at 12 month mark?"
  }

}

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
    label: "Users Active at 6 Months"
    description: "Was user active at 6 month mark?"
  }

}
