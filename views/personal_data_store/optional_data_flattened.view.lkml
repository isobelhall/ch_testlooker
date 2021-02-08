view: optional_data_flattened {
  derived_table: {
    sql: select  opt_data.user_id,
        json_objectagg(opt_data.`key`, opt_data.value) as hl_properties
      from personal_data_store.optional_data as opt_data
      group by 1
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

  dimension: hl_properties {
    type: string
    hidden: yes
    sql: ${TABLE}.hl_properties ;;
  }

  set: detail {
    fields: [user_id, hl_properties]
  }
}
