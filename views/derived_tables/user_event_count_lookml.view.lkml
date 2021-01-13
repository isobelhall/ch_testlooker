# If necessary, uncomment the line below to include explore_source.

# include: "changinghealth_test_ihall.model.lkml"

view: user_event_count {
  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: count { field: events.count }
      filters: {
        field: events.event_date
        value: "NOT NULL"
      }
    }
  }
  dimension: ppuid {
    hidden: yes
    primary_key: yes
    label: "0. General CHUID"
    description: "Platform identifier for each participant"
  }
  dimension: count {
    hidden: yes
    label: "8. Platform Events Count - Platform Use"
    type: number
  }

  measure: average {
    type:  average
    label: "Average Events Per Day Per User ID"
    sql:  ${count} ;;
  }
}
