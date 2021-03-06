view: units {
  sql_table_name: userhub.units ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Add dimension for identifying programme for partner
  dimension: programme_name {
    label: "Programme"
    case: {
      when: {
        sql: ${id} in (13,17,20,43,47) ;;
        label: "Management"
      }
      when: {
        sql: ${id} = 38 ;;
        label: "Programme-derived"
      }
      when: {
        sql: ${id} in (44, 45) ;;
        label: "Not Live"
      }
    }
  }

  # Add dimension for Healthy Living route of referral
  dimension: HL_route_of_referral {
    label: "HL Route of Referral"
    case: {
      when: {
        sql: ${id} = 47 ;;
        label: "Private Beta Self-Referral"
      }
      when: {
        sql: ${id} = 37 ;;
        label: "Live - Self referral"
      }
      when: {
        sql: ${id} = 36 ;;
        label: "Live - Hub / Other referral"
      }
      when: {
        sql: ${id} = 35 ;;
        label: "Live - GP referrals"
      }
      when: {
        sql: ${id} = 34 ;;
        label: "Live - Controlled onboarding"
      }
    }
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
    hidden: yes
    view_label: "1. User Account"
    label: "Unit/Programme Name"
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
    view_label: "1. User Account"
    label: "Unit/Programme Name"
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
