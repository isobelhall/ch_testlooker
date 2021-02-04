view: optional_data_flattened {
  derived_table: {
    sql: select  optional_data.user_id,
        JSON_OBJECTAGG(optional_data.`key`, optional_data.value) as properties1
from personal_data_store.optional_data as optional_data
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

  dimension: properties1 {
    type: string
    hidden: yes
    sql: ${TABLE}.properties1 ;;
  }

  dimension: diabetes_diagnosis_updated {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.diabetes_diagnosis_updated"));;}
  dimension: diabetes_status_healthy_living_update {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.diabetes_diagnosis_updated"));;}

  set: detail {
    fields: [user_id, properties1]
  }
}
