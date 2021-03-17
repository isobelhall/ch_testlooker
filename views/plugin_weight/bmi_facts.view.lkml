view: bmi_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: height {field: pops_data_replica_flattened.height}
      column: weight {field: weight_tracks.weight_goal}
    }
  }
  dimension: ppuid {
    primary_key: yes
    hidden: yes
    description: "Platform ID for each user"
  }
  dimension: height {
    label: "BMI_Height"
    hidden:  no
    type:  number
    sql:  ${TABLE}.height ;;
  }










}
