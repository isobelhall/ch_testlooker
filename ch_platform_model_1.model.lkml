connection: "mysql_connection_events"

datagroup: daily_refresh {
  sql_trigger: SELECT CURRENT_DATE();;
  max_cache_age: "24 hours"
}

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
label: "CH Master Model"


explore: users {
  persist_with: daily_refresh
  group_label: "Changing Health"
  label: "Platform Data Model"

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

#view_label: "0. General"

  join: user_3appts {
    view_label: "0. General"
    sql_on: ${users.ppuid} = ${user_3appts.CHUID} ;;
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

  # Add relationship join for Feedbacks as view necessary for Healthy Living Feedback Report
  join: feedbacks {
    sql_on: ${users.id} = ${feedbacks.user_id} ;;
    relationship: many_to_one
    view_label: "1. User Account"
  }

  join: articles_accessed {
    sql_on: ${users.id} = ${articles_accessed.user_id} ;;
    #changed to "one to many"
    relationship: many_to_one
    view_label: "7.1 Activity Data - Articles"
  }

  join: articles {
    sql_on: ${articles_accessed.article_id} = ${articles.id} ;;
    relationship: many_to_one
    view_label: "7.1 Activity Data - Articles"
  }

    join: article_facts {
      sql_on: ${article_facts.ppuid} = ${users.ppuid};;
      relationship: one_to_one
      view_label: "7.1 Activity Data - Articles"
    }

    join: video_facts {
      sql_on: ${video_facts.ppuid}= ${users.ppuid};;
      relationship: one_to_one
      view_label: "7.1 Activity Data - Articles"
    }

  join: weight_tracks {
    sql_on: ${weight_tracks.user_id} =${users.id};;
    relationship: many_to_one
    view_label: "7.2 Activity Data - Weight Tracking"
  }

  join: weight_facts {
    sql_on: ${weight_facts.ppuid} = ${users.ppuid};;
    relationship: one_to_one
    view_label: "7.2 Activity Data - Weight Tracking"
  }

  join: food_tracks {
    sql_on: ${users.id} = ${food_tracks.user_id} ;;
    relationship: many_to_one
    view_label: "7.3 Activity Data - Meal/Food Tracking"
  }
  join: food_facts {
    sql_on: ${users.id} = ${food_facts.ppuid} ;;
    relationship: many_to_one
    view_label: "7.3 Activity Data - Meal/Food Tracking"
  }

  join: fit_tracks {
    sql_on:  ${fit_tracks.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "7.4 Activity Data - Step/Fit Tracking"
  }

  join: fit_tracks_facts {
    sql_on: ${fit_tracks_facts.ppuid} = ${users.ppuid};;
    relationship: one_to_one
    view_label: "7.4 Activity Data - Step/Fit Tracking"
  }

  join: progress_statistics {
    sql_on: ${progress_statistics.user_id} = ${users.id};;
    relationship: many_to_one
    view_label: "7.5 Activity Data - Progress Tracking"
  }

  join: goals {
    sql_on:   ${goals.user_id} = ${users.id};;
    relationship: many_to_one
    view_label: "7.6 Activity Data - All Goals Tracking"
  }

  join: goal_facts {
    sql_on:   ${users.ppuid} = ${goal_facts.ppuid};;
    relationship: many_to_one
    view_label: "7.6 Activity Data - All Goals Tracking"
  }

  join: profiles {
    sql_on: ${goals.profile_id} = ${profiles.id} ;;
    relationship: many_to_one
    view_label: "7.6 Activity Data - All Goals Tracking"
  }
  join: appointments {
    sql_on: ${appointments.user_id} = ${users.id};;
    relationship: one_to_many
    view_label: "6. Coaching"
  }
  join: appointments_coaches {
    from: coaches
    sql_on: ${appointments.coach_id} =  ${coaches.id};;
    relationship: many_to_one
    view_label: "6. Coaching"
  }

  join: coaches{
    sql_on:  ${coaches.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "6. Coaching"
  }

  join: coach_users {
    sql_on:  ${coach_users.user_id} = ${users.id}  ;;
    relationship: many_to_one
    view_label: "6. Coaching"
  }

  join: derived_activity_2 {
    view_label: "7. Activity Data"
    sql_on: ${derived_activity_2.uid} = ${users.id} ;;
    relationship: many_to_one
  }

  join: derived_signup_activity {
    view_label: "7a. Sign Up Activity Data"
    sql_on:  ${derived_signup_activity.uid} = ${users.id} ;;
    relationship: many_to_one
  }

# REMOVED 25/02/2021 - sessions... needs linking to derived_activity_3,
#  join: sessions {
#    view_label: "7. Activity Data"
#    sql_on: ${derived_activity_2.uid} = ${sessions.session_id} ;;
#    relationship: many_to_one
#  }
#
#  join: session_end {
#    view_label: "7. Activity Data"
#    sql_on: ${session_end.object_id} = ${derived_activity_2.object_id} ;;
#    relationship: one_to_one
#  }

  join: plugins_accessed {
    sql_on: ${plugins_accessed.user_id} = ${users.id};;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: program_plugins {
    sql_on: ${program_plugins.id} = ${plugins_accessed.plugin_id} ;;
    relationship: many_to_one
    view_label: "7. Activity Data"
  }

  join: user_data {
    sql_on: ${users.id} = ${user_data.user_id} ;;
    relationship: one_to_one
    view_label: "3. Identifiables"
  }

# flattened views for pops and optional data table
  join: pops_data_replica_flattened {
    sql_on: ${pops_data_replica_flattened.user_id} =  ${users.id} ;;
    relationship: many_to_one
    view_label: "2. Demographics / User Attributes"
  }

  join: optional_data_flattened {
    sql_on:${optional_data_flattened.user_id} =  ${users.id} ;;
    relationship: many_to_one
    view_label: "2. HL Demographics / User Attributes"
  }

# Add relationship and join for excluding participants from reporting
  join: exclude_participants {
    sql_on: ${exclude_participants.ch_uid} = ${users.ppuid} ;;
    relationship: many_to_one
    view_label: "1. User Account"
  }

# REMOVED 25/02/2021 - derived_engagement... needs linking to derived_activity_3,
#  join: derived_engagement_3m {
#    view_label: "1a. Engagement at 3m"
#    sql_on: ${derived_engagement_3m.ppuid} = ${users.ppuid} ;;
#    relationship: one_to_one
#  }
#  join: derived_engagement_6m {
#    view_label: "1a. Engagement at 6m"
#    sql_on: ${derived_engagement_6m.ppuid} = ${users.ppuid} ;;
#    relationship: one_to_one
#  }

}
