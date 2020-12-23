view: derived_activity_tables {

  derived_table: {
    sql: SELECT
           article.articles_accessed.user_id "UID",
           article.articles.id "ObjectID",
           articles.name "ObjectValue",
           articles.type "ObjectType",
           article.articles_accessed.created_at "ObjectAccessedDate"
      FROM  article.articles_accessed
      JOIN article.articles ON article.articles_accessed.article_id  = article.articles.id
      UNION
      SELECT
           plugin_weight.weight_tracks.user_id "UID",
           plugin_weight.weight_tracks.id "ObjectID",
           plugin_weight.weight_tracks.weight_goal "ObjectValue",
           'weight tracker' as "ObjectType",
           plugin_weight.weight_tracks.created_at "ObjectAccessedDate"
      FROM  plugin_weight.weight_tracks
      UNION
      SELECT
           step.fit_tracks.user_id "UID",
           step.fit_tracks.id "ObjectID",
           step.fit_tracks.logging_steps "ObjectValue",
           'step tracker' as "ObjectType",
           step.fit_tracks.created_at "ObjectAccessedDate"
      FROM  step.fit_tracks
      UNION
      SELECT
           plugin_food.food_tracks.user_id "UID",
           plugin_food.food_tracks.id "ObjectID",
           plugin_food.food_tracks.label_foods "ObjectValue",
           'food tracker' as "ObjectType",
           plugin_food.food_tracks.created_at "ObjectAccessedDate"
      FROM  plugin_food.food_tracks
       UNION
      SELECT
           coaching.appointments.user_id "UID",
           coaching.appointments.id "ObjectID",
           coaching.appointments.result "ObjectValue",
           'appointment' as "ObjectType",
           coaching.appointments.since "ObjectAccessedDate"
      FROM  coaching.appointments      ;;
  }

  measure: count {
    label: "Count - All Activities"
    type: count
    drill_fields: [detail*]
  }

  dimension: uid {
    hidden: yes
    type: number
    sql: ${TABLE}.UID ;;
  }

  dimension: object_id {
    hidden: yes
    type: number
    sql: ${TABLE}.ObjectID ;;
  }

  dimension: object_value {
    label: "All Activities - Value"
    type: string
    sql: ${TABLE}.ObjectValue ;;
  }

  dimension: object_type {
    label: "All Activities - Type"
    type: string
    sql: ${TABLE}.ObjectType ;;
  }

  dimension_group: object_accessed_date {
    label: "All Activities - Acivity Completed"
    type: time
    sql: ${TABLE}.ObjectAccessedDate ;;
  }

  set: detail {
    fields: [uid, object_id, object_value, object_type, object_accessed_date_time]
  }
}
