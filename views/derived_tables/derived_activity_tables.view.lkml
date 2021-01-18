view: derived_activity_tables {

  derived_table: {
  #ISOBEL: ADD IN ALL PLATFORM USAGE (EG, PLUGINS, GOALS)
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
           program.plugins_accessed.user_id "UID",
           program.plugins.id "ObjectID",
           program.plugins.system_name "ObjectName",
           'plugins' as "ObjectType",
           program.plugins_accessed.created_at "ObjectAccessedDate"
      FROM program.plugins_accessed
      JOIN program.plugins ON program.plugins_accessed.plugin_id = program.plugins.id
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
      UNION
      SELECT
           plugin_goal.goals.user_id "UID",
           plugin_goal.goals.id "ObjectID",
           plugin_goal.profiles.name "ObjectValue",
           'goals' as "ObjectType",
           plugin_goal.goals.created_at "ObjectAccessedDate"
      FROM plugin_goal.goals
      JOIN plugin_goal.profiles ON plugin_goal.goals.profile_id = plugin_goal.profiles.id

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
#      ObjectAccessedDate,
#      LAG(ObjectAccessedDate),
#      OVER (PARTITION BY UID ORDER BY ObjectAccessedDate) AS previous_date,
#      ObjectAccessedDate - LAG(ObjectAccessedDate)
#      OVER (PARTITION BY UID ORDER BY ObjectAccessedDate) AS difference_between_dates
#      FROM derived_activity_table
#      ORDER BY UID, ObjectAccessedDate;;
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
    label: "All Activities - Object ID"
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
      hour_of_day,
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
