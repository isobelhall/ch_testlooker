view: pops_data_replica_flattened {
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
    type: string
    sql: ${TABLE}.properties ;;
  }

  set: detail {
    fields: [user_id, properties]
  }
}
