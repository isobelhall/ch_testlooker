view: derived_accounts_by_date {
  derived_table: {
    explore_source: users {
      column: count2 {}
      column: created_date {}
    }
  }
  measure: count2 {
    label: "Accounts Created"
    type: number
  }
  dimension: created_date {
    primary_key: yes
    label: "Account Created Date (Dimension)"
    type: date
  }
}

view: derived_logins_by_date {
  derived_table: {
    explore_source: users {
      column: count2 {}
      column: created_date { field: logins.created_date }
    }
  }
  measure: count2 {
    label: "Logins This Day"
    type: number
  }
  dimension: created_date {
    hidden: yes
    primary_key: yes
    label: "Logins Date (Dimension)"
    type: date
  }
}
