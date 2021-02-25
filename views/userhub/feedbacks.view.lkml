view: feedbacks {
  sql_table_name: userhub.feedbacks ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    label: "Feedback UID"
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: comment {
    label: "Feedback Comments"
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension_group: created {
    type: time
    label: "Feedback Date"
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

  dimension: package_id {
    type: number
    hidden: yes
    sql: ${TABLE}.package_id ;;
  }

  dimension: page_name {
    label: "Page Name"
    type: string
    sql: ${TABLE}.page_name ;;
  }

  dimension: page_type {
    label: "Page Type"
    type: string
    sql: ${TABLE}.page_type ;;
  }

  dimension: page_url {
    label: "Page Name URL"
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: program_id {
    type: number
    hidden: yes
    sql: ${TABLE}.program_id ;;
  }

  dimension: rating {
    label: "Feedback Rating"
    type: string
    sql: ${TABLE}.rating ;;
  }

  dimension: unit_id {
    type: number
    hidden: yes
    sql: ${TABLE}.unit_id ;;
  }

  dimension_group: updated {
    type: time
    hidden: yes
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

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      page_name,
      users.id,
      units.id,
      units.name,
      units.display_name
    ]
  }
}
