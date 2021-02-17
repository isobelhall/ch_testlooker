view: profiles {
  sql_table_name: plugin_goal.profiles ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: active_limit {
    hidden: yes
    type: number
    sql: ${TABLE}.active_limit ;;
  }

  dimension: category_id {
    hidden: yes
    type: number
    sql: ${TABLE}.category_id ;;
  }

  dimension: ch_profile_image {
    hidden: yes
    type: yesno
    sql: ${TABLE}.ch_profile_image ;;
  }

  dimension_group: completed {
    hidden: yes
    view_label: "7. Activity Data"
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
    hidden: yes
    type: yesno
    sql: ${TABLE}.completed_markable ;;
  }

  dimension: description {
    hidden: yes
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: icon_id {
    hidden: yes
    type: number
    sql: ${TABLE}.icon_id ;;
  }

  dimension: input_meta {
    hidden: yes
    type: string
    sql: ${TABLE}.input_meta ;;
  }

  dimension: input_type {
    hidden: yes
    type: string
    sql: ${TABLE}.input_type ;;
  }

  dimension: is_readonly {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_readonly ;;
  }

  dimension: message {
    hidden: yes
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: name {
    group_label: "Goal Data"
    view_label: "7. Activity Data"
    label: "Goal Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: status {
    hidden: yes
    type: yesno
    sql: ${TABLE}.status ;;
  }

  dimension: template_slug {
    hidden: yes
    type: string
    sql: ${TABLE}.template_slug ;;
  }

  dimension: title {
    group_label: "Goal Data"
    label: "Profile Title"
    type: string
    hidden: yes
    sql: ${TABLE}.title ;;
  }

  dimension: type {
    group_label: "Goal Data"
    label: "Profile Type"
    hidden: yes
    type: yesno
    sql: ${TABLE}.type ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [id, name, goals.count]
  }
}
