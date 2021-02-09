view: optional_data_flattened {
  derived_table: {
    sql: select  optional_data.user_id,
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

  dimension: diabetes_diagnosis_updated {sql: JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.diabetes_diagnosis_updated"));;}
  dimension: diabetes_diagnosis_healthy_living {
    type: string
    label: "healthy_living_diagnosis_time_english"
    case: {
      when: {
        sql: ${diabetes_diagnosis_updated} = "1" ;;
        label: "In the last 12 months"
      }
      when: {
        sql: ${diabetes_diagnosis_updated} = "2" ;;
        label: "1-5 years"
      }
      when: {
        sql: ${diabetes_diagnosis_updated} = "3" ;;
        label: "6-10 years"
      }
      when: {
        sql: ${diabetes_diagnosis_updated} = "4" ;;
        label: "More than 10 years"
      }
    }
  }
  dimension: diabetes_status_healthy_living_update {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.diabetes_status_healthy_living_update"));;}
  dimension: diabetes_status_healthy_living {
    type: string
    label: "diabetes_status_healthy_living_english"
    case: {
      when: {
        sql: ${diabetes_status_healthy_living_update} = "1" ;;
        label: "I have type 2 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = "2" ;;
        label: "I'm at risk of type 2 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = "3" ;;
        label: "I care for / support a person with type 2 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = "4" ;;
        label: "I have type 1 diabetes"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = "5" ;;
        label: "None of the above"
      }
      when: {
        sql: ${diabetes_status_healthy_living_update} = "6" ;;
        label: "I am a healthcare professional / I work in the diabetes field"
      }
    }
  }
  dimension: disability_status_healthy_living_update {sql: JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.disability_status_healthy_living_update"));;}
  dimension: disability_status_healthy_living {
    type: string
    label: "disability_status_healthy_living_english"
    case: {
      when: {
        sql: ${disability_status_healthy_living_update} = "1" ;;
        label: "Yes"
      }
      when: {
        sql: ${disability_status_healthy_living_update} = "2" ;;
        label: "No"
      }
      when: {
        sql: ${disability_status_healthy_living_update} = "3" ;;
        label: "Prefer not to say"
      }
    }
  }
  dimension: ethnicity_healthy_living {sql: JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.ethnicity_healthy_living"));;}
  dimension: ethnic_background_healthy_living {
    type: string
    label: "ethnicity_healthy_living_english"
    case: {
      when: {
        sql: ${ethnicity_healthy_living} = "1" ;;
        label: "White - British"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "2" ;;
        label: "White - Irish"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "3" ;;
        label: "Any other white background"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "4" ;;
        label: "Mixed - White and Black Caribbean"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "5" ;;
        label: "Mixed - White and Black African"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "6" ;;
        label: "Mixed - White and Asian"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "7" ;;
        label: "Any other mixed background"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "8" ;;
        label: "Asian - Indian"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "9" ;;
        label: "Asian - Pakistani"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "10" ;;
        label: "Asian - Bangladeshi"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "11" ;;
        label: "Black or Black British - Caribbean"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "12" ;;
        label: "Black or Black British - African"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "13" ;;
        label: "Any other Black background"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "14" ;;
        label: "Any other"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "15" ;;
        label: "Prefer not to say"
      }
      when: {
        sql: ${ethnicity_healthy_living} = "16" ;;
        label: "Any other Asian background"
      }
    }
  }
  dimension: gender_m_f_i_p {sql: JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.gender_m_f_i_p"));;}
  dimension: gender_mfip_healthy_living {
    type: string
    label: "gender_healthy_living_english"
    case: {
      when: {
        sql: ${gender_m_f_i_p} = "0" ;;
        label: "Male"
      }
      when: {
        sql: ${gender_m_f_i_p} = "1" ;;
        label: "Female"
      }
      when: {
        sql: ${gender_m_f_i_p} = "2" ;;
        label: "Intersex"
      }
      when: {
        sql: ${gender_m_f_i_p} = "3" ;;
        label: "Prefer not to say"
      }
    }
  }
  dimension: language_healthy_living_updated {sql: JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.language_healthy_living_updated"));;}
  dimension: language_healthy_living {
    type: string
    label: "language_healthy_living_english"
    case: {
      when: {
        sql: ${language_healthy_living_updated} = "1" ;;
        label: "English"
      }
      when: {
        sql: ${language_healthy_living_updated} = "2" ;;
        label: "Arabic"
      }
      when: {
        sql: ${language_healthy_living_updated} = "3" ;;
        label: "Bengali (with Sylheti and Chatgaya)"
      }
      when: {
        sql: ${language_healthy_living_updated} = "4" ;;
        label: "Chinese (all Chinese)"
      }
      when: {
        sql: ${language_healthy_living_updated} = "5" ;;
        label: "French"
      }
      when: {
        sql: ${language_healthy_living_updated} = "6" ;;
        label: "German"
      }
      when: {
        sql: ${language_healthy_living_updated} = "7" ;;
        label: "Gujarati"
      }
      when: {
        sql: ${language_healthy_living_updated} = "8" ;;
        label: "Italian"
      }
      when: {
        sql: ${language_healthy_living_updated} = "9" ;;
        label: "Lithuanian"
      }
      when: {
        sql: ${language_healthy_living_updated} = "10" ;;
        label: "Panjabi"
      }
      when: {
        sql: ${language_healthy_living_updated} = "11" ;;
        label: "Persian / Farsi"
      }
      when: {
        sql: ${language_healthy_living_updated} = "12" ;;
        label: "Polish"
      }
      when: {
        sql: ${language_healthy_living_updated} = "13" ;;
        label: "Portuguese"
      }
      when: {
        sql: ${language_healthy_living_updated} = "14" ;;
        label: "Romanian"
      }
      when: {
        sql: ${language_healthy_living_updated} = "15" ;;
        label: "Somali"
      }
      when: {
        sql: ${language_healthy_living_updated} = "16" ;;
        label: "Spanish"
      }
      when: {
        sql: ${language_healthy_living_updated} = "17" ;;
        label: "Tagalog / Filipino"
      }
      when: {
        sql: ${language_healthy_living_updated} = "18" ;;
        label: "Tamil"
      }
      when: {
        sql: ${language_healthy_living_updated} = "19" ;;
        label: "Turkish"
      }
      when: {
        sql: ${language_healthy_living_updated} = "20" ;;
        label: "Urdu"
      }
      when: {
        sql: ${language_healthy_living_updated} = "21" ;;
        label: "Welsh"
      }
      when: {
        sql: ${language_healthy_living_updated} = "22" ;;
        label: "Other"
      }
    }
  }
  dimension: serious_mental_illness_status {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.serious_mental_illness_status"));;}
  dimension: serious_mental_illness_healthy_living {
    type: string
    label: "serious_mental_illness_healthy_living_english"
    case: {
      when: {
        sql: ${serious_mental_illness_status} = "1" ;;
        label: "Yes"
      }
      when: {
        sql: ${serious_mental_illness_status} = "2" ;;
        label: "No"
      }
      when: {
        sql: ${serious_mental_illness_status} = "3" ;;
        label: "Prefer not to say"
      }
    }
  }
  dimension: smoking_status_healthy_living_updated {sql:JSON_UNQUOTE(JSON_EXTRACT(${hl_properties}, "$.smoking_status_healthy_living_updated"));;}
  dimension: smokingstatus_healthy_living {
    type: string
    label: "smokingstatus_healthy_living_english"
    case: {
      when: {
        sql: ${smoking_status_healthy_living_updated} = "1" ;;
        label: "Yes"
      }
      when: {
        sql: ${smoking_status_healthy_living_updated} = "2" ;;
        label: "No"
      }
    }
  }

  set: detail {
    fields: [user_id, hl_properties]
  }
}
