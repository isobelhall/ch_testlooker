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
    group_label: "Article/Video Data"
    label: "Article Created"
    description: "Date this article was created"
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
    group_label: "Article/Video Data"
    label: "Article Deleted"
    description: "When was an article deleted from the platform"
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
    group_label: "Article/Video Data"
    view_label: "7. Activity Data"
    label: "Article/Video Name"
    description: "What is the name of the article or video"
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
    group_label: "Article/Video Data"
    view_label: "7. Activity Data"
    label: "Article Type (article/video)"
    description: "Is this an article or a video? Filter by this if you want to distinguish between articles and videos"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension_group: article_updated {
    group_label: "Article/Video Data"
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

  dimension: article_updated_by {
    group_label: "Article/Video Data"
    description: "ID of user who updated the article or video"
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
    description: "Count of articles/video available in the platform by name"
    label: "Count - Article Names"
    type: count
    drill_fields: [id, name, articles_accessed.count]
  }

}
