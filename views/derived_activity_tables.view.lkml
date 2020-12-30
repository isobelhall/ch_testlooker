view: derived_activity_tables {

  derived_table: {
    #PROBLEM: must be ordered by date, and by ppt ID
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
      FROM  coaching.appointments
      SELECT
      UID,
      ObjectAccessedDate,
      LAG(ObjectAccessedDate),
      OVER (PARTITION BY UID ORDER BY ObjectAccessedDate) AS previous_date,
      ObjectAccessedDate - LAG(ObjectAccessedDate)
      OVER (PARTITION BY UID ORDER BY ObjectAccessedDate) AS difference_between_dates,
      ORDER BY UID, ObjectAccessedDate;;
  }

##DIMENSION GROUP - difference between activity and one before it
#SELECT
#city,
# year,
#      population_needing_house,
#      LAG(population_needing_house),
#      OVER (PARTITION BY city ORDER BY year ) AS previous_year,
#      population_needing_house - LAG(population_needing_house)
#   OVER (PARTITION BY city ORDER BY year ) AS difference_previous_year
#FROM   housing
#ORDER BY city, year

### code for attempt at using SQL LAG
#      SELECT
#      UID,
#      ObjectAccessedDate
#      LAG(ObjectAccessedDate)
#      OVER (PARTITION BY UID ORDER BY ObjectAccessedDate) AS previous_date
#      ObjectAccessedDate - LAG(ObjectAccessedDate)
#      OVER (PARTITION BY UID ORDER BY ObjectAccessedDate) AS difference_between_dates
#      FROM derived_activity_tables
#      ORDER BY UID, ObjectAccessedDate
##

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
    primary_key: yes
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


  #PROBLEM: need output with full date-time stamp, not just date as yyyy-mm-dd
  dimension_group: object_accessed_date {
    label: "All Activities - Acivity Completed"
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
    sql: ${TABLE}.ObjectAccessedDate ;;
  }

  #PROBLEM: dimension group - time between next object accessed date

  set: detail {
    fields: [object_id, object_value, object_type, object_accessed_date_time]
  }
}
