view: articles_accessed {
  sql_table_name: article.articles_accessed ;;
  drill_fields: [id]

  dimension: id {
    hidden:  yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: article_id {
    hidden:  yes
    type: number
    # hidden: yes
    sql: ${TABLE}.article_id ;;
  }

  dimension_group: created {
    group_label: "Article/Video Data"
    view_label: "7. Activity Data"
    description: "When this article or video was accessed by a user"
    label: "Article/Video Accessed"
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

  dimension: program_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.program_id ;;
  }

  dimension_group: updated {
    group_label: "Article/Video Data"
    hidden:  yes
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

  dimension: user_id {
    hidden:  yes
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    group_label: "Article/Video Data"
    hidden: yes
    label: "Count - Articles Accessed"
    type: count
    drill_fields: [id, users.id, articles.id, articles.name]
  }

  measure: average {
    group_label: "Article/Video Data"
    hidden: yes
    label: "Average - Articles Accessed"
    type: average
    drill_fields: [id, users.id, articles.id, articles.name]
  }

  measure: average_distinct {
    group_label: "Article/Video Data"
    hidden: yes
    label: "Average Distinct - Articles Accessed"
    type: average
    drill_fields: [id, users.id, articles.id, articles.name]
  }
}
