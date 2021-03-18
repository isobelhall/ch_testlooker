connection: "mysql_connection_events"

#include: "/**/*.view.lkml"                 # include all views in this project
#label: "Test CH Master Model"

#explore: users {
#  persist_for: "24 hours"
#  group_label: "Master Build Test IH"
#  label: "Healthy Living"

#  hidden:  yes

#  always_filter: {
#    filters: [units.display_name: "NHSE"]
#  }

#  join: logins {
#    view_label: "Participant Accounts"
#    sql_on: ${users.id} = ${logins.user_id} ;;
#    relationship: one_to_many
#  }
#
#  join: units_users {
#    view_label: "Participant Accounts"
#    sql_on: ${users.id} = ${units_users.user_id} ;;
#    relationship: one_to_many
#  }
#
#  join: units {
#    sql_on: ${units_users.unit_id} = ${units.id} ;;
#    relationship: many_to_one
#    view_label: "Participant Accounts"
#  }
#
#  join: user_event_logs {
#    sql_on: ${users.id} = ${user_event_logs.user_id} ;;
#    relationship:  many_to_one
#    view_label: "Participant Accounts"
#  }

#  join: events {
#    view_label: "Participant Engagement"
#    sql_on: ${users.id} = ${events.user_id} ;;
#    relationship: one_to_many
#  }

#  join: sessions {
#    view_label: "Participant Engagement"
#    sql_on: ${events.session_id} = ${sessions.session_id} ;;
#    relationship: many_to_one
#  }

#}
