view: users {
  view_label: "1. User Account"
  sql_table_name: userhub.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: account_enabled {
    label: "Account Enabled"
    type: yesno
    sql: ${TABLE}.account_enabled ;;
  }

  dimension: account_unit_id {
    hidden: yes
    type: number
    sql: ${TABLE}.account_unit_id ;;
  }

  dimension: avatar_id {
    hidden: yes
    type: number
    sql: ${TABLE}.avatar_id ;;
  }

  dimension: confirm_code {
    hidden: yes
    type: string
    sql: ${TABLE}.confirm_code ;;
  }

  dimension_group: created {
    label: "User Created"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_by {
    hidden: yes
    type: number
    sql: ${TABLE}.created_by ;;
  }

  dimension: created_type {
    hidden: yes
    type: string
    sql: ${TABLE}.created_type ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: distance_unit {
    hidden: yes
    type: number
    sql: ${TABLE}.distance_unit ;;
  }

  dimension: email_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.email_hash ;;
  }

  dimension: enabled {
    label: "Account Enabled"
    type: yesno
    sql: ${TABLE}.enabled ;;
  }

  dimension: enabled_2fa {
    hidden: yes
    type: yesno
    sql: ${TABLE}.enabled_2fa ;;
  }

  dimension: global_role {
    hidden: yes
    type: string
    sql: ${TABLE}.global_role ;;
  }

  dimension: has_completed_profile {
    label: "Profile Completed"
    type: yesno
    sql: ${TABLE}.has_completed_profile ;;
  }

  dimension: initial_token {
    hidden: yes
    type: string
    sql: ${TABLE}.initial_token ;;
  }

  dimension: is_shared_coach {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_shared_coach ;;
  }

  dimension: locale_id {
    hidden: yes
    type: number
    sql: ${TABLE}.locale_id ;;
  }

  dimension_group: modified {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.modified_at ;;
  }

  dimension: modified_by {
    hidden: yes
    type: string
    sql: ${TABLE}.modified_by ;;
  }

  dimension: package_id {
    hidden: yes
    type: number
    sql: ${TABLE}.package_id ;;
  }

  dimension: password_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.password_hash ;;
  }

  dimension: personal_data_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.personal_data_store_id ;;
  }

  dimension: phone_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.phone_hash ;;
  }
# What is this?
  dimension: ppuid {
    label: "CHUID"
    type: string
    sql: ${TABLE}.ppuid ;;
  }

  dimension: status {
    label: "Status"
    type: string
    sql: ${TABLE}.status ;;
  }

# What is this?
  dimension: suid {
    type: string
    sql: ${TABLE}.suid ;;
  }

  dimension: timezone {
    hidden: yes
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension_group: updated {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: updated_by {
    hidden: yes
    type: number
    sql: ${TABLE}.updated_by ;;
  }

  dimension: updated_type {
    hidden: yes
    type: string
    sql: ${TABLE}.updated_type ;;
  }

  dimension: upload_id {
    hidden: yes
    type: number
    sql: ${TABLE}.upload_id ;;
  }

  measure: count {
    label: "Participant Count"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      appointments.count,
      articles_accessed.count,
      coach_users.count,
      coaches.count,
      feedbacks.count,
      food_tracks.count,
      goals.count,
      logins.count,
      optional_data.count,
      organizations.count,
      program_plugins.count,
      plugins_accessed.count,
      pops_data_replica.count,
      progress_statistics.count,
      units.count,
      units_users.count,
      user_data.count,
      user_event_logs.count,
      user_items.count,
      weight_tracks.count
    ]
  }
}
