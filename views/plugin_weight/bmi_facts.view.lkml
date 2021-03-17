view: bmi_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: height { field: pops_data_replica_flattened.height}
      column: weight { field: weight_tracks.weight_goal}
    }
  }
  # ppuid
  dimension: ppuid {
    primary_key: yes
    hidden: yes
    description: "Platform ID for each user"
  }
  # height
  dimension: height {

    label : "bmi_height_test"
    sql:  ${TABLE}.height ;;
  }
  # weight
  dimension: weight {

    label: "bmi_weight_test"
    sql: ${TABLE}.weight ;;
  }
  # bmi
  dimension: bmi {

    label: "bmi_test"
    sql: ROUND((${weight} / (${height} * ${height}), 3);;
  }



}
