connection: "mysql_connection_events"

datagroup: daily_refresh {
  sql_trigger: SELECT CURRENT_DATE();;
  max_cache_age: "24 hours"
}

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
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
  hidden:  yes
  #persist_for: "24 hours"
  persist_with: daily_refresh
  group_label: "Master Build Test SL"
  label: "Platform Use Data"

  join: logins {
    view_label: "1. User Account"
    sql_on: ${users.id} = ${logins.user_id} ;;
    #relationship changed from many_to_one, to one_to_many
    relationship: many_to_one
  }

  join: units_users {
    view_label: "1. User Account"
    sql_on: ${users.id} = ${units_users.user_id} ;;
    #changed to "one to many"
    relationship: many_to_one
  }

  join: derived_characteristics {
    sql_on: ${derived_characteristics.ppuid} = ${users.ppuid} ;;
    relationship: one_to_one
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

  join: articles_accessed {
    sql_on: ${users.id} = ${articles_accessed.user_id} ;;
    #changed to "one to many"
    relationship: many_to_one
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
    view_label: "6. Coaching"
  }
  join: appointments_coaches {
    from: coaches
    sql_on: ${appointments.coach_id} =  ${coaches.id};;
    relationship: many_to_one
    view_label: "6. Coaching"
  }

#23/12/2020 - hidden many headers and labelled
  join: coaches{
    sql_on: ${users.id} = ${coaches.user_id} ;;
    relationship: one_to_many
    view_label: "6. Coaching"
  }

#23/12/2020 - hidden many headers and labelled
  join: coach_users {
    sql_on: ${users.id} = ${coach_users.user_id}  ;;
    relationship: one_to_many
    view_label: "6. Coaching"
  }

  join: goals {
    sql_on: ${users.id} =  ${goals.user_id};;
    relationship: one_to_many
    view_label: "7. Activity Data"
  }

  join: profiles {
    sql_on: ${goals.profile_id} = ${profiles.id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

#replaced with line 151
#  join: derived_activity_tables {
#    sql_on: ${derived_activity_tables.uid} = ${users.id} ;;
#    relationship: many_to_one
#    view_label: "7. Activity Data"
#  }

  join: derived_activity_2 {
    view_label: "7. Activity Data"
    sql_on: ${users.id} = ${derived_activity_2.uid} ;;
    relationship: one_to_many
  }


  join: sessions {
    view_label: "7. Activity Data"
    sql_on: ${derived_activity_2.uid} = ${sessions.session_id} ;;
    relationship: many_to_one
  }

  join: plugins_accessed {
    sql_on: ${plugins_accessed.user_id} = ${users.id};;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }
  #added on 06.01.2021 - had to unhide ID in plugins_accessed view to get to work
  join: program_plugins {
    sql_on: ${program_plugins.id} = ${plugins_accessed.plugin_id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }
  #added on 12.01.2021 - removed explore for user data so adding join to this explore
  join: user_data {
    sql_on: ${users.id} = ${user_data.user_id} ;;
    relationship: one_to_one
    view_label: "3. Identifiables"
  }


 # join: user_event_count {
#    sql_on: ${user_event_count.ppuid} = ${events.user_id} ;;
 #   relationship: many_to_one
#    view_label: "7. Activity Data"
#  }

#  join: events_activity_join {
#    from: derived_activity_tables
#    sql_on: ${events.pk} = ${derived_activity_tables.object_id} ;;
#    relationship: many_to_one
#    view_label: "7. Activity Data"
#  }

  join: pops_data_replica_flattened {
    sql_on: ${users.id} = ${pops_data_replica_flattened.user_id} ;;
    relationship: many_to_one
    view_label: "2. Demographics / User Attributes"
  }

#########
}

explore: derived_activity_tables {
  persist_for: "24 hours"
  group_label: "Master Build Test IH"
  view_label: "7. Activity Data (Derived)"
}
