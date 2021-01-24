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
    hidden: yes
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
    view_label: "1. User Account"
    label: "Account Created"
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

  dimension: days_since_account_created {
    type: number
    label: "Days since creation"
    sql: DATEDIFF(now(), ${created_raw}) ;;
  }

  dimension: account_older_than_90_days {
    type: yesno
    sql: CASE WHEN ${days_since_account_created} > 90 THEN true ELSE false END ;;
  }

  dimension: is_referred {
    label: "Status 1. Is referred"
    type: yesno
    sql: CASE WHEN ${created_raw} IS NOT NULL THEN true
    ELSE false END ;;

  }

    dimension: is_activated {
    label: "Status 2. Is Activated"
    type: yesno
    sql: CASE WHEN ${is_referred} IS NOT NULL AND ${account_enabled} = TRUE THEN true
    ELSE false END ;;
  }

  dimension: has_done_activity {
    type: number
    sql: COUNT(${id}) FROM ${} WHERE condition;
 ;;
}

#  dimension: is_engaged {
#    label: "Status 3. Is Engaged"
#    type: yesno
#    sql: CASE WHEN ${is_referred} IS NOT NULL AND ${account_enabled} = TRUE AND 'count of activitys' THEN true
#      ELSE false END ;;
#  }


  dimension: is_deleted {
    label: "Status 4. Is Deleted"
    type: yesno
    sql: CASE WHEN ${deleted_raw} IS NOT NULL THEN true
      ELSE false END ;;
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
    view_label: "1. User Account"
    label: "Account Deleted"
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
    #which is the value representing if a user account is enabled? This one, or account_enabled (row 13)
    hidden: yes
    type: yesno
    sql: ${TABLE}.enabled ;;
  }

  dimension: enabled_2fa {
    hidden: yes
    type: yesno
    sql: ${TABLE}.enabled_2fa ;;
  }

  dimension: global_role {
    view_label: "1. User Account"
    label: "Global Role"
    hidden: yes
    type: string
    sql: ${TABLE}.global_role ;;
  }

  dimension: has_completed_profile {
    hidden: yes
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
    view_label: "1. User Account"
    label: "CHUID"
    description: "Platform identifier for each participant"
    type: string
    sql: ${TABLE}.ppuid ;;
  }

  dimension: status {
    label: "Account Status"
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

# What is this?
  dimension: suid {
    view_label: "0. General"
    label: "Partner UID"
    hidden: yes
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

  measure: count2 {
    view_label: "0. General"
    description: "Count of all participants against other selected criteria"
    label: "Count - Participants"
    type: count
    drill_fields: [detail*]
  }

  measure: count1 {
    label: "Count - Participants"
    description: "Count of all participants against other selected criteria"
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
