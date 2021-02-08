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

  dimension: diabetes_diagnosis_time_healthy_living {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.diabetes_diagnosis_time_healthy_living));;}
  dimension: diagnosis_time_healthy_living {
    type: string
    label: "Healthy Living Diagnosis Time"
    case: {
      when: {
        sql: ${diabetes_diagnosis_time_healthy_living} = 1 ;;
        label: "In the last 12 months"
      }
      when: {
        sql: ${diabetes_diagnosis_time_healthy_living} = 2 ;;
        label: "1-5 years"
      }
      when: {
        sql: ${diabetes_diagnosis_time_healthy_living} = 3 ;;
        label: "6-10 years"
      }
      when: {
        sql: ${diabetes_diagnosis_time_healthy_living} = 4 ;;
        label: "More than 10 years"
      }
    }
  }
  dimension: diabetes_status_healthy_living_update {sql: JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.diabetes_status_healthy_living_update));;}
  dimension: diabetes_status_healthy_living {
    type: string
    label: "Healthy Living Diabetes Status"
    case: {
      when: {
        sql: ${diabetes_status_healthy_living_update} = 1 ;;
        label: "I have type 2 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = 2 ;;
        label: "I'm at risk of type 2 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = 3 ;;
        label: "I care for / support a person with type 2 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = 4 ;;
        label: "I have type 1 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = 5 ;;
        label: "None of the above"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = 6 ;;
        label: "I am a healthcare professional / I work in the diabetes field"
      }
    }
  }
  dimension: disability_status_healthy_living_update {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.disability_status_healthy_living_update));;}
  dimension: ethnicity_healthy_living {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.ethnicity_healthy_living));;}
  dimension: gender_m_f_i_p_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.gender_m_f_i_p_healthy_living));;}
  dimension: language_healthy_living_updated {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.language_healthy_living_updated));;}
  dimension: serious_mental_illness_status_healthy_living {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.serious_mental_illness_status_healthy_living));;}
  dimension: smoking_status_healthy_living_updated {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.smoking_status_healthy_living_updated));;}


  set: detail {
    fields: [user_id, hl_properties]
  }
}
