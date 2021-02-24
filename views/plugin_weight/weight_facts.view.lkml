view: weight_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: count { field: weight_tracks.count }
      column: count_hit_target {field: weight_tracks.count_hit_target}
    }
  }
  dimension: ppuid {
    primary_key: yes
    hidden: yes
    description: "Platform identifier for each participant"
  }
  dimension: count {
    label: "Count - Weights Tracked"
    type: number
  }

  dimension: count_hit_target {
    hidden: yes
    label: "Count - Hit Weight Target"
    type: number
  }

  dimension: user_has_tracked_weights {
    type: yesno
    sql:
    CASE WHEN ${count} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

  dimension: has_tracked_weight {
    label: "User has hit a weight target"
    type: yesno
    sql:
    CASE WHEN ${count_hit_target} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

 }
