connection: "mysql_connection_events"

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
label: "Test CH Master Model"
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
explore: users {
  persist_for: "24 hours"
  group_label: "Master Build Test IH"
  label: "1. User Account"

#23/12/2020
# - Users, any unnecessary headers hidden
# - Logins, any unnecessary headers hidden
  join: logins {
    view_label: "1. User Account"
    sql_on: ${users.id} = ${logins.user_id}d ;;
    #relationship changed from many_to_one, to one_to_many
    relationship: one_to_many
  }

# - Units_users, any unnecessary headers hidden
  join: units_users {
    view_label: "1. User Account"
    sql_on: ${users.id} = ${units_users.user_id} ;;
    #changed to "one to many"
    relationship: one_to_many
  }

#Removed as replica of above?
#  join: units {
#    sql_on: ${units_users.unit_id} = ${units.id} ;;
#    relationship: many_to_one
#    view_label: "1. User Account"
#  }

  join: user_event_logs {
    sql_on: ${users.id} = ${user_event_logs.user_id} ;;
    relationship:  many_to_one
    view_label: "1. User Account"
  }

  join: articles_accessed {
    sql_on: ${users.id} = ${articles_accessed.user_id} ;;
    #changed to "one to many"
    relationship: one_to_many
    view_label: "7. Activity Data"
  }
  join: articles {
    sql_on: ${articles_accessed.article_id} = ${articles.id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: weight_tracks {
    #swapped order round (from Weight -> users, to users -> weights) for consistency
    sql_on: ${users.id} = ${weight_tracks.user_id} ;;
    relationship: one_to_many
    view_label: "7. Activity Data"
  }
  join: food_tracks {
    sql_on: ${users.id}= ${food_tracks.user_id};;
    relationship: one_to_many
    view_label: "7. Activity Data"
  }
  join: fit_tracks {
    sql_on: ${users.id} = ${fit_tracks.user_id};;
    relationship: one_to_many
    view_label: "7. Activity Data"
  }
  join: progress_statistics {
    sql_on: ${users.id} = ${progress_statistics.user_id} ;;
    relationship: one_to_many
    view_label: "7. Activity Data"
  }
  join: appointments {
    sql_on: ${users.id} =  ${appointments.user_id};;
    relationship: one_to_many
    view_label: "7. Activity Data"
  }

  join: coaches{
    sql_on: ${users.id} = ${coaches.id} ;;
    relationship: one_to_many
    view_label: "6. Coaching"
  }


#########
  join: coach_users {
    sql_on: ${coach_users.user_id} = ${users.id} ;;
    relationship: one_to_many
    view_label: "6. Coaching"
  }

  join: goals {
    sql_on: ${goals.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: profiles {
    sql_on: ${goals.profile_id} = ${profiles.id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }
}
explore:  user_data {
  persist_for: "24 hours"
  group_label: "Master Build Test IH"
  label: "3. Identifiables / Contact"
}

explore: pops_data_replica {
  persist_for: "24 hours"
  group_label: "Master Build Test IH"
  label: "2. Demographics"
}

explore: derived_activity_tables {
  persist_for: "24 hours"
  group_label: "Master Build Test IH"
  label: "7. Activity Data - Derived"
}
