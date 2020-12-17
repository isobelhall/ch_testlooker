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
  label: "Master User Data"

  join: logins {
    sql_on: ${users.id} = ${logins.user_id}d ;;
    relationship: many_to_one
    view_label: "1. User Account"
  }

  join: units_users {
    sql_on: ${users.id} = ${units_users.user_id} ;;
    relationship: many_to_one
    view_label: "1. User Account"
  }

  join: units {
    sql_on: ${units_users.unit_id} = ${units.id} ;;
    relationship: many_to_one
    view_label: "1. User Account"
  }

  join: user_event_logs {
    sql_on: ${users.id} = ${user_event_logs.user_id} ;;
    relationship:  many_to_one
    view_label: "1. User Account"
  }

  join: user_data {
    sql_on: ${users.id} = ${user_data.user_id} ;;
    relationship: one_to_one
    view_label: "2. Identifiables"
  }

  join: articles_accessed {
    sql_on: ${users.id} = ${articles_accessed.user_id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: articles {
    sql_on: ${articles_accessed.article_id} = ${articles.id} ;;
    relationship: one_to_many
    view_label: "7. Activity Data"
  }

  join: weight_tracks {
    sql_on: ${weight_tracks.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: food_tracks {
    sql_on: ${food_tracks.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: fit_tracks {
    sql_on: ${fit_tracks.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: progress_statistics {
    sql_on: ${progress_statistics.user_id} = ${users.id}  ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: pops_data_replica {
    sql_on: ${pops_data_replica.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "2. Demographics and Other Attributes"
  }

  join: optional_data {
    sql_on: ${optional_data.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "2. Demographics and Other Attributes"
  }

}
