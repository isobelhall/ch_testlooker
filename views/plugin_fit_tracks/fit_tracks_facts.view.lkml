view: fit_tracks_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: has_counted_steps { field: fit_tracks.has_counted_steps }
      column: count_hit_step_target {field: fit_tracks.count_hit_target}
    }
  }
  dimension: ppuid {
    primary_key: yes
    hidden: yes
    description: "Platform identifier for each participant"
  }
  dimension: has_counted_steps {
    label: "Count - Fit track/steps Tracked"
    type: number
  }

#  dimension: user_has_tracked_steps {
#    label: "User has tracked steps"
#    type: yesno
#    sql:
#    CASE WHEN ${count} > 0 THEN TRUE
#    ELSE FALSE
#    END;;
#  }

  dimension: count_hit_step_target {
    hidden: yes
    label: "Count - Hit Fit track/steps Target"
    type: number
  }


  dimension: has_tracked_steps {
    label: "User has hit a Fit track/steps target"
    type: yesno
    sql:
    CASE WHEN ${count_hit_step_target} > 0 THEN TRUE
    ELSE FALSE
    END;;
  }





 }
