view: goal_facts {

    derived_table: {
      explore_source: users {
        column: ppuid {}
        column: name { field: profiles.name }


      }

    }
 }
