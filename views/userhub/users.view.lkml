view: users {
  sql_table_name: userhub.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: account_enabled {
    type: yesno
    sql: ${TABLE}.account_enabled ;;
  }

  dimension: account_unit_id {
    type: number
    sql: ${TABLE}.account_unit_id ;;
  }

  dimension: avatar_id {
    type: number
    sql: ${TABLE}.avatar_id ;;
  }

  dimension: confirm_code {
    type: string
    sql: ${TABLE}.confirm_code ;;
  }

  dimension_group: created {
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
    type: number
    sql: ${TABLE}.created_by ;;
  }

  dimension: created_type {
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
    type: number
    sql: ${TABLE}.distance_unit ;;
  }

  dimension: email_hash {
    type: string
    sql: ${TABLE}.email_hash ;;
  }

  dimension: enabled {
    type: yesno
    sql: ${TABLE}.enabled ;;
  }

  dimension: enabled_2fa {
    type: yesno
    sql: ${TABLE}.enabled_2fa ;;
  }

  dimension: global_role {
    type: string
    sql: ${TABLE}.global_role ;;
  }

  dimension: has_completed_profile {
    type: yesno
    sql: ${TABLE}.has_completed_profile ;;
  }

  dimension: initial_token {
    type: string
    sql: ${TABLE}.initial_token ;;
  }

  dimension: is_shared_coach {
    type: yesno
    sql: ${TABLE}.is_shared_coach ;;
  }

  dimension: locale_id {
    type: number
    sql: ${TABLE}.locale_id ;;
  }

  dimension_group: modified {
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
    type: string
    sql: ${TABLE}.modified_by ;;
  }

  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
  }

  dimension: password_hash {
    type: string
    sql: ${TABLE}.password_hash ;;
  }

  dimension: personal_data_store_id {
    type: number
    sql: ${TABLE}.personal_data_store_id ;;
  }

  dimension: phone_hash {
    type: string
    sql: ${TABLE}.phone_hash ;;
  }

  dimension: ppuid {
    type: string
    sql: ${TABLE}.ppuid ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: suid {
    type: string
    sql: ${TABLE}.suid ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension_group: updated {
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
    type: number
    sql: ${TABLE}.updated_by ;;
  }

  dimension: updated_type {
    type: string
    sql: ${TABLE}.updated_type ;;
  }

  dimension: upload_id {
    type: number
    sql: ${TABLE}.upload_id ;;
  }

  measure: count {
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
