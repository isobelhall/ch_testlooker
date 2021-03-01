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
        primary_key: yes
        description: "Platform identifier for each participant"
      }
      dimension: count {
        label: "How many food events this user has tracked"
        type: number
      }
      dimension: user_has_tracked_meals {
        label: "User has tracked meals"
        type: number
      }

 }
