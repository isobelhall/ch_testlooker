view: food_facts {

      derived_table: {
        explore_source: users {
          column: ppuid {}
          column: count { field: food_tracks.count }
        }
      }
      dimension: ppuid {
        description: "Platform identifier for each participant"
      }

      dimension: count {
        label: "How many food events this user has tracked TEST2"
        type: number
      }
      dimension: user_has_tracked_meals {
        label: "User has tracked meals TEST2"
        sql:
        CASE
        WHEN ${count} > 0 THEN TRUE
        ELSE FALSE
        END;;
        type: yesno
      }

 }
