view: pops_data_replica_flattened {
  #This view flattens the pops data table so we are able to see line by line the different
  #user characteristics

  derived_table: {
    sql: SELECT  pops_data_replica.user_id,
        users.ppuid "CHUID",
        JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value) as properties
FROM opd.pops_data_replica as pops_data_replica
LEFT JOIN userhub.users on opd.pops_data_replica.user_id = userhub.users.id
GROUP BY 1, 2

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

  dimension: chuid {
    type: string
    sql: ${TABLE}.CHUID ;;
  }

  dimension: properties {
    hidden: yes
    type: string
    sql: ${TABLE}.properties ;;
  }

  dimension: activity_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.activity_plan"));;}
  dimension: bmi {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.bmi"));;}
  dimension: choose_your_eating_plan_female {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_female"));;}
  dimension: choose_your_eating_plan_french {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_french"));;}
  dimension: choose_your_eating_plan_german_version {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_german_version"));;}
  dimension: choose_your_eating_plan_male {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_eating_plan_male"));;}
  dimension: choose_your_physical_activity_plan {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choose_your_physical_activity_plan"));;}
  dimension: choosing_your_physical_activity_plan {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.choosing_your_physical_activity_plan"));;}
  dimension: consent_to_share_data_with_your_gp_practice {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.consent_to_share_data_with_your_gp_practice"));;}
  dimension: driver {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.driver"));;}
  dimension: eating_plan {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.eating_plan"));;}
  dimension: employed {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.employed"));;}
  dimension: ethnic_background_duk {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnic_background_duk"));;}
  dimension: ethnicity {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnicity"));;}
  dimension: ethnicity_english {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnicity"));;
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

    }
  dimension: family_diabetes_duk {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.family_diabetes_duk"));;}
  dimension: gender {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender"));;}
  dimension: gender_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender_duk"));;}
  dimension: gender_m_f_p {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gender_m_f_p"));;}
  dimension: gp_practice {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.gp_practice"));;}
  dimension: height {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.height"));;}
  dimension: i_agree {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.i_agree"));;}
  dimension: insulin_check {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.insulin_check"));;}
  dimension: language {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.language"));;}
  dimension: medication {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.medication"));;}
  dimension: navigator_call_phoenix {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.navigator_call_phoenix"));;}
  dimension: result_duk {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.result_duk"));;}
  dimension: result_score_duk {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.result_score_duk"));;}
  dimension: smoker {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.smoker"));;}
  dimension: time_since_diagnosis {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.time_since_diagnosis"));;}
  dimension: tricky_situations_plan {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.tricky_situations_plan"));;}
  dimension: tricky_situations_problem {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.tricky_situations_problem"));;}
  dimension: weight {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.weight"));;}
  dimension: weight_reminder {sql:JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.weight_reminder"));;}



  set: detail {
    fields: [user_id, properties]
  }
}
