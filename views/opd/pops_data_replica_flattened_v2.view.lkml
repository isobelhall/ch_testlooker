view: pops_data_replica_flatted_v2 {
  derived_table: {
    sql: SELECT  users.ppuid as "CHUID",
        opd.pops_data_replica.user_id,
        JSON_OBJECTAGG(pops_data_replica.`key`, pops_data_replica.value) as properties

FROM userhub.users as users
JOIN opd.pops_data_replica on userhub.users.id = opd.pops_data_replica.user_id
GROUP BY users.ppuid
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: chuid {
    type: string
    sql: ${TABLE}.CHUID ;;
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
  dimension: driver {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.driver"));;}
  dimension: eating_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.eating_plan"));;}
  dimension: employed {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.employed"));;}
  dimension: ethnic_background_duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnic_background_duk"));;}
  dimension: ethnicity {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.ethnicity"));;}
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
  dimension: weight_reminder {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties}, "$.tricky_situations_problem"));;}


  set: detail {
    fields: [chuid, user_id, properties]
  }
}
