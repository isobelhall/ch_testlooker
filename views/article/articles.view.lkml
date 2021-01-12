view: articles {
  sql_table_name: article.articles ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: category_id {
    hidden: yes
    type: number
    sql: ${TABLE}.category_id ;;
  }

  dimension_group: created {
    label: "Article Created"
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
    label: "Article Deleted"
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

  dimension: languages_used {
    hidden:  yes
    type: string
    sql: ${TABLE}.languages_used ;;
  }

  dimension: name {
    view_label: "7. Activity"
    label: "Article Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: region_id {
    hidden: yes
    type: number
    sql: ${TABLE}.region_id ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: type {
    hidden: yes
    #split into article and video.
    view_label: "7. Activity"
    label: "Article Type (article/video)"
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
    type: number
    sql: ${TABLE}.updated_by ;;
  }

  dimension: updated_type {
    hidden: yes
    type: string
    sql: ${TABLE}.updated_type ;;
  }

  measure: count {
    hidden: yes
    label: "Count - Article Names"
    type: count
    drill_fields: [id, name, articles_accessed.count]
  }
}
