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
    sql: ${TABLE}.properties1 ;;
  }

  dimension: diabetes_diagnosis_time_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.diabetes_diagnosis_time_healthy_living"));;}
  dimension: diabetes_status_healthy_living_update {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.diabetes_status_healthy_living_update"));;}
  dimension: disability_status_healthy_living_update {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.disability_status_healthy_living_update"));;}
  dimension: ethnicity_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.ethnicity_healthy_living"));;}
  dimension: gender_m_f_i_p_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.gender_m_f_i_p_healthy_living"));;}
  dimension: language_healthy_living_updated {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.language_healthy_living_updated"));;}
  dimension: serious_mental_illness_status_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.serious_mental_illness_status_healthy_living"));;}
  dimension: smoking_status_healthy_living_updated {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.smoking_status_healthy_living_updated"));;}


  set: detail {
    fields: [user_id, properties1]
  }
}
