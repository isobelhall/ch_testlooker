view: profiles {
  sql_table_name: plugin_goal.profiles ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: active_limit {
    type: number
    sql: ${TABLE}.active_limit ;;
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.category_id ;;
  }

  dimension: ch_profile_image {
    type: yesno
    sql: ${TABLE}.ch_profile_image ;;
  }

  dimension_group: completed {
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
    sql: ${TABLE}.completed_at ;;
  }

  dimension: completed_markable {
    type: yesno
    sql: ${TABLE}.completed_markable ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: icon_id {
    type: number
    sql: ${TABLE}.icon_id ;;
  }

  dimension: input_meta {
    type: string
    sql: ${TABLE}.input_meta ;;
  }

  dimension: input_type {
    type: string
    sql: ${TABLE}.input_type ;;
  }

  dimension: is_readonly {
    type: yesno
    sql: ${TABLE}.is_readonly ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    type: yesno
    sql: ${TABLE}.status ;;
  }

  dimension: template_slug {
    type: string
    sql: ${TABLE}.template_slug ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: type {
    type: yesno
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, goals.count]
  }
}
