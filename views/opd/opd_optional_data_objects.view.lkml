view: opd_optional_data_objects {
  sql_table_name: opd.optional_data_objects ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: api_access {
    type: yesno
    sql: ${TABLE}.api_access ;;
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

  dimension: display_description {
    type: string
    sql: ${TABLE}.display_description ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: meta {
    type: string
    sql: ${TABLE}.meta ;;
  }

  dimension: optional_data_category_id {
    type: number
    sql: ${TABLE}.optional_data_category_id ;;
  }

  dimension: secure {
    type: yesno
    sql: ${TABLE}.secure ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: system_name {
    type: string
    sql: ${TABLE}.system_name ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
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

  measure: count {
    type: count
    drill_fields: [id, system_name, display_name]
  }
}
