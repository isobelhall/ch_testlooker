view: bmi_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {
        field: users.ppuid
      }
      column: height {
        field: pops_data_replica_flattened.height
      }
      column: weight {
        field: weight_tracks.weight_goal
      }
    }
  }
  dimension: ppuid {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ppuid ;;
  }
  dimension_group: height {
    label: "bmi_height_test"
    sql: ${TABLE}.height ;;
  }
  dimension: weight {
    label: "bmi_weight_test"
    sql: ${TABLE}.weight ;;
  }
}
