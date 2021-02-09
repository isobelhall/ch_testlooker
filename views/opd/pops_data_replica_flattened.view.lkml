view: pops_data_replica_flattened {
  derived_table: {
    sql: SELECT  pops_data_replica.user_id,
        JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value) as properties
FROM opd.pops_data_replica as pops_data_replica
GROUP BY 1
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

  dimension: properties {
    type: string
    hidden: yes
    sql: ${TABLE}.properties ;;
  }

  dimension: activity_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.activity_plan"));;}
  dimension: bmi {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.bmi"));;}
  dimension: choose_your_eating_plan_female {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_female"));;}
  dimension: choose_your_eating_plan_french {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_french"));;}
  dimension: choose_your_eating_plan_german_version {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_german_version"));;}
  dimension: choose_your_eating_plan_male {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_male"));;}
  dimension: choose_your_physical_activity_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_physical_activity_plan"));;}
  dimension: choosing_your_physical_activity_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choosing_your_physical_activity_plan"));;}
  dimension: consent_to_share_data_with_your_gp_practice {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.consent_to_share_data_with_your_gp_practice"));;}
  dimension: consent_to_share_data_with_your_gp_practice_english {
    type: string
    label: "consent_gp_practice_english"
    case: {
      when: {
        sql: ${consent_to_share_data_with_your_gp_practice} = 1 ;;
        label: "Yes"
      }
      when: {
        sql: ${consent_to_share_data_with_your_gp_practice} = 2 ;;
        label: "No"
      }
      else: "None"
    }
  }
  dimension: driver {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.driver"));;}
  dimension: driver_english {
    type: string
    label: "driver_english"
    case: {
      when: {
        sql: ${driver} = 1 ;;
        label: "No"
      }
      when: {
        sql: ${driver} = 2 ;;
        label: "Yes"
      }
      else: "None"
    }
  }
  dimension: eating_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.eating_plan"));;}
  dimension: employed {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.employed"));;}
  dimension: employed_english {
    type: string
    label: "employed_english"
    case: {
      when: {
        sql: ${employed} = 1  ;;
        label: "No"
      }
      when: {
        sql: ${employed} = 2 ;;
        label: "Yes"
      }
      else: "None"
    }
  }
  dimension: ethnic_background_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnic_background_duk"));;}
  dimension: ethnicity {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnicity"));;}
  dimension: ethnicity_english {
    type: string
    label: "ethnicity_english"
    case: {
      when: {
        sql: ${ethnicity} = "1" ;;
        label: "White - British"
      }
      when: {
        sql: ${ethnicity} = "2" ;;
        label: "White - Irish"
      }
      when: {
        sql: ${ethnicity} = "3" ;;
        label: "Any other white background"
      }
      when: {
        sql: ${ethnicity} = "4" ;;
        label: "Mixed - White and Black Caribbean"
      }
      when: {
        sql: ${ethnicity} = "5" ;;
        label: "Mixed - White and Black African"
      }
      when: {
        sql: ${ethnicity} = "6" ;;
        label: "Mixed - White and Asian"
      }
      when: {
        sql: ${ethnicity} = "7" ;;
        label: "Any other mixed background"
      }
      when: {
        sql: ${ethnicity} = "8" ;;
        label: "Asian - Indian"
      }
      when: {
        sql: ${ethnicity} = "9" ;;
        label: "Asian - Pakistani "
      }
      when: {
        sql: ${ethnicity} = "10" ;;
        label: "Asian - Bangladeshi"
      }
      when: {
        sql: ${ethnicity} = "11" ;;
        label: "Any other Asian background"
      }
      when: {
        sql: ${ethnicity} = "12" ;;
        label: "Black or Black British - Caribbean"
      }
      when: {
        sql: ${ethnicity} = "13" ;;
        label: "Black or Black British - African"
      }
      when: {
        sql: ${ethnicity} = "14" ;;
        label: "Any other Black background"
      }
      when: {
        sql: ${ethnicity} = "15" ;;
        label: "Any other"
      }
      when: {
        sql: ${ethnicity} = "16" ;;
        label: "Prefer not to say"
      }
      else: "None"
    }
  }
  dimension: family_diabetes_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.family_diabetes_duk"));;}
  dimension: gender {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender"));;}
  dimension: gender_english {
    type: string
    label: "gender_english"
    case: {
      when: {
        sql: ${gender} = 1 ;;
        label: "Male"
      }
      when: {
        sql: ${gender} = 2 ;;
        label: "Female"
      }
      else: "None"
    }
  }
  dimension: gender_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender_duk"));;}
  dimension: gender_m_f_p {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender_m_f_p"));;}
  dimension: gender_mfp_english {
    type: string
    label: "gender_mfp_english"
    case: {
      when: {
        sql: ${gender_m_f_p} = 1 ;;
        label: "Male"
      }
      when: {
        sql: ${gender_m_f_p} = 2 ;;
        label: "Female"
      }
      when: {
        sql: ${gender_m_f_p} = 3 ;;
        label: "Prefer not to say"
      }
      else: "None"
    }
  }
  dimension: gp_practice {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gp_practice"));;}
  dimension: height {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.height"));;}
  dimension: i_agree {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.i_agree"));;}
  dimension: insulin_check {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.insulin_check"));;}
  dimension: language {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.language"));;}
  dimension: medication {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.medication"));;}
  dimension: medication_english {
    type: string
    label: "medication_english"
    case: {
      when: {
        sql: ${medication} = 1 ;;
        label: "No"
      }
      when: {
        sql: ${medication} = 2 ;;
        label: "Yes"
      }
      else: "None"
    }
  }
  dimension: navigator_call_phoenix {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.navigator_call_phoenix"));;}
  dimension: result_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.result_duk"));;}
  dimension: result_score_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.result_score_duk"));;}
  dimension: smoker {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.smoker"));;}
  dimension: smoker_english {
    type: string
    label: "smoker_english"
    case: {
      when: {
        sql: ${smoker} = 1 ;;
        label: "No"
      }
      when: {
        sql: ${smoker} = 2 ;;
        label: "Yes"
      }
      else: "None"
    }
  }
  dimension: time_since_diagnosis {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.time_since_diagnosis"));;}
  dimension: time_since_diagnosis_english {
    type: string
    label: "diagnosis_time_english"
    case: {
      when: {
        sql: ${time_since_diagnosis} = 1 ;;
        label: "Less than 12 months"
      }
      when: {
        sql: ${time_since_diagnosis} = 2 ;;
        label: "1-5 years"
      }
      when: {
        sql: ${time_since_diagnosis} = 3 ;;
        label: "6-10 years"
      }
      when: {
        sql: ${time_since_diagnosis} = 4 ;;
        label: "10+ years"
      }
    }
  }
  dimension: tricky_situations_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.tricky_situations_plan"));;}
  dimension: tricky_situations_problem {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.tricky_situations_problem"));;}
  dimension: pops_weight {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.weight"));;}
  dimension: weight_reminder {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.weight_reminder"));;}

  set: detail {
    fields: [user_id, properties]
  }
}
