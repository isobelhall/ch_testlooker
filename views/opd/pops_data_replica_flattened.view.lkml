view: pops_data_replica_flattened {
  derived_table: {
    sql: SELECT  pops_data_replica.user_id,
        JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value) as "properties"
FROM opd.pops_data_replica as pops_data_replica
GROUP BY 1,2
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
    hidden: yes
    type: string
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
  dimension: driver {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.driver"));;}
  dimension: eating_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.eating_plan"));;}
  dimension: employed {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.employed"));;}
  dimension: ethnic_background_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnic_background_duk"));;}
  dimension: ethnicity {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnicity"));;}
  dimension: ethnicity_english {
    label: "ethnicity_english"
    case: {
      when: {
        sql: ${ethnicity} = 1 ;;
        label: "White - British"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 2 ;;
        label: "White - Irish"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 3 ;;
        label: "Any other white background"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 4 ;;
        label: "Mixed - White and Black Caribbean"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 5 ;;
        label: "Mixed - White and Black African"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 6 ;;
        label: "Mixed - White and Asian"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 7 ;;
        label: "Any other mixed background"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 8 ;;
        label: "Asian - Indian"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 9 ;;
        label: "Asian - Pakistani "
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 10 ;;
        label: "Asian - Bangladeshi"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 11 ;;
        label: "Any other Asian background"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 12 ;;
        label: "Black or Black British - Caribbean"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 13 ;;
        label: "Black or Black British - African"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 14 ;;
        label: "Any other Black background"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 15 ;;
        label: "Any other"
      }
    }
    case: {
      when: {
        sql: ${ethnicity} = 16 ;;
        label: "Prefer not to say"
      }
    }
  }
  dimension: family_diabetes_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.family_diabetes_duk"));;}
  dimension: gender {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender"));;}
  dimension: gender_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender_duk"));;}
  dimension: gender_m_f_p {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender_m_f_p"));;}
  dimension: gp_practice {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gp_practice"));;}
  dimension: height {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.height"));;}
  dimension: i_agree {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.i_agree"));;}
  dimension: insulin_check {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.insulin_check"));;}
  dimension: language {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.language"));;}
  dimension: medication {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.medication"));;}
  dimension: navigator_call_phoenix {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.navigator_call_phoenix"));;}
  dimension: result_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.result_duk"));;}
  dimension: result_score_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.result_score_duk"));;}
  dimension: smoker {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.smoker"));;}
  dimension: time_since_diagnosis {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.time_since_diagnosis"));;}
  dimension: tricky_situations_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.tricky_situations_plan"));;}
  dimension: tricky_situations_problem {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.tricky_situations_problem"));;}
  dimension: weight {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.weight"));;}
  dimension: weight_reminder {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.weight_reminder"));;}

  set: detail {
    fields: [user_id, properties]
  }
}
