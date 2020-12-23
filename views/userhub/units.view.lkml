view: units {
  sql_table_name: userhub.units ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: display_name {
    view_label: "9. Unit Information"
    label: "Unit Name"
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: enabled {
    hidden: yes
    type: yesno
    sql: ${TABLE}.enabled ;;
  }

  dimension: is_default {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_default ;;
  }

  dimension: logo_id {
    hidden: yes
    type: number
    sql: ${TABLE}.logo_id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: organization_id {
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: type {
    hidden: yes
    type: string
    sql: ${TABLE}.type ;;
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

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      display_name,
      organizations.id,
      organizations.name,
      users.id,
      feedbacks.count,
      items.count,
      units_users.count
    ]
  }
}
