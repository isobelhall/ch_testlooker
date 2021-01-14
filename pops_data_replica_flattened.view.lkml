view: pops_data_replica_flattened {
  derived_table: {
    sql: SELECT  users.ppuid "CHUID",
        pops_data_replica.user_id,
        JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value)
FROM userhub.users
JOIN opd.pops_data_replica ON opd.pops_data_replica.user_id = users.id
GROUP BY 1,2
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: chuid {
    type: string
    sql: ${TABLE}.CHUID ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: json_objectaggpops_data_replica_key_pops_data_replica_value {
    type: string
    label: "JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value)"
    sql: ${TABLE}.`JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value)` ;;
  }

  set: detail {
    fields: [chuid, user_id, json_objectaggpops_data_replica_key_pops_data_replica_value]
  }
}
