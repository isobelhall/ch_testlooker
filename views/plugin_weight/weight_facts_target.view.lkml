view: weight_target_facts {
  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: hit_target { field: weight_tracks.hit_target }
      filters: {
        field: weight_tracks.hit_target
        value: "Yes"
      }
    }
  }
  dimension: ppuid {
    primary_key: yes
    hidden: yes
    description: "Platform identifier for each participant"
  }

  dimension: hit_target {
    label: "Has this user hit a weight target?"
    type: yesno
    sql:
        CASE
          WHEN LENGTH(${ppuid}) > 0 THEN TRUE
          ELSE FALSE
        END;;
  }

  measure: count {
    type: count_distinct
    group_label: "Weight Data"
    label: "Count - Hit Weight Target"
    sql: ${hit_target} ;;
  }
}
