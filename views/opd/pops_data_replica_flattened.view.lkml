view: pops_data_replica_flattened {
  #This view flattens the pops data table so we are able to see line by line the different
  #user characteristics

  derived_table: {
    sql: SELECT  pops_data_replica.user_id,
        JSON_OBJECTAGG(pops_data_replica.value, pops_data_replica.`key`) as properties
FROM opd.pops_data_replica as pops_data_replica
GROUP BY 1
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: properties {
    hidden: yes
    type: string
    sql: ${TABLE}.properties ;;
  }

  dimension: activity_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.activity_plan"));;}
  dimension: bmi {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.bmi"));;}
  dimension: choose_your_eating_plan_female {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_female"));;}

  set: detail {
    fields: [user_id, properties]
  }
}
