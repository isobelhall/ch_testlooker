view: food_facts {

  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: count { field: food_tracks.count }
      column: user_has_tracked_meals { field: food_tracks.user_has_tracked_meals }
    }
  }

  dimension: ppuid {
    hidden: yes
    description: "Platform identifier for each participant"
  }
  dimension: count {
    label: "Meal/Food Tracking Count - Count Food Tracker"
    type: number
  }
  dimension: user_has_tracked_meals {
    label: "User Has tracked Meals"
    type: number
  }

 }
