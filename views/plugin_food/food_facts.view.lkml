view: food_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: count { field: food_tracks.count }
      column: count_hit_step_target {field: food_tracks.count_hit_target}
    }
  }


 }
