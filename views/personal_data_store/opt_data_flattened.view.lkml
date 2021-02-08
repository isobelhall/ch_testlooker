view: opt_data_flattened {
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
    sql: ${TABLE}.hl_properties ;;
  }

  dimension: diabetes_diagnosis_time_healthy_living {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.diabetes_diagnosis_time_healthy_living"));;}
  dimension: diabetes_status_healthy_living_update {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.diabetes_status_healthy_living_update"));;}
  dimension: disability_status_healthy_living_update {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.disability_status_healthy_living_update"));;}
  dimension: ethnicity_healthy_living {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.ethnicity_healthy_living"));;}
  dimension: gender_m_f_i_p_healthy_living {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.gender_m_f_i_p_healthy_living"));;}
  dimension: language_healthy_living_updated {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.language_healthy_living_updated"));;}
  dimension: serious_mental_illness_status_healthy_living {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.serious_mental_illness_status_healthy_living"));;}
  dimension: smoking_status_healthy_living_updated {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.smoking_status_healthy_living_updated"));;}

  set: detail {
    fields: [user_id, hl_properties]
  }
}
