view: optional_data_flattened {
  derived_table: {
    sql: select optional_data.user_id,
        json_objectagg(optional_data.`key`, optional_data.value) as hl_properties
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

  dimension: hl_properties {
    type: string
    hidden: yes
    sql: ${TABLE}.hl_properties ;;
  }

  dimension: diabetes_diagnosis_time_healthy_living  {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, $.diabetes_diagnosis_time_healthy_living));;}
  dimension: diagnosis_time_healthy_living {
    type: string
    label: "HL Diagnosis Time"
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


  set: detail {
    fields: [user_id, hl_properties]
  }
}
