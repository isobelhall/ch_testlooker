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
  dimension: diabetes_diagnosis_time_english {
    type: string
    label: "HL Diabetes Diganosis Time English"
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
  dimension: diabetes_status_healthy_living_update {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.diabetes_status_healthy_living_update"));;}
  dimension: diabetes_status_english {
    type: string
    label: "HL Diabetes Status English"
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
  dimension: disability_status_healthy_living_update {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.disability_status_healthy_living_update"));;}
  dimension: disability_status_english {
    type: string
    label: "HL Disability Status"
    case: {
      when: {
        sql: ${disability_status_healthy_living_update} = 1 ;;
        label: "Yes"
      }
      when: {
        sql: ${disability_status_healthy_living_update} = 2 ;;
        label: "No"
      }
    }
  }
  dimension: ethnicity_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.ethnicity_healthy_living"));;}
  dimension: gender_m_f_i_p_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.gender_m_f_i_p_healthy_living"));;}
  dimension: language_healthy_living_updated {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.language_healthy_living_updated"));;}
  dimension: serious_mental_illness_status_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.serious_mental_illness_status_healthy_living"));;}
  dimension: smoking_status_healthy_living_updated {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties1}, "$.smoking_status_healthy_living_updated"));;}


  set: detail {
    fields: [user_id, properties1]
  }
}
