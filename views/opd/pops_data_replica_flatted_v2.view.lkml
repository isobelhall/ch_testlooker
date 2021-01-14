view: pops_data_replica_flatted_v2 {
  derived_table: {
    sql: SELECT  users.ppuid as "CHUID",
        opd.pops_data_replica.user_id,
        JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value) as properties

FROM userhub.users as users
JOIN opd.pops_data_replica on userhub.users.id = opd.pops_data_replica.user_id
GROUP BY users.ppuid
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

  dimension: properties {
    type: string
    sql: ${TABLE}.properties ;;
  }

  set: detail {
    fields: [chuid, user_id, properties]
  }
}
