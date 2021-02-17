view: weight_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: count { field: weight_tracks.count }
    }
  }
  dimension: ppuid {
    label: "1. User Account CHUID"
    description: "Platform identifier for each participant"
  }
  dimension: count {
    label: "Count - Weights Tracked"
    type: number
  }
  dimension: has_tracked_weight {
    group_label: "Weight Data"
    label: "User has recorded a weight"
    type: yesno
    sql:
    CASE WHEN ${count} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }

 }
