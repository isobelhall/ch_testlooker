view: pops_data_replica_flattened {
  derived_table: {
    sql: SELECT  opd.pops_data_replica.user_id,
        JSON_OBJECTAGG(opd.pops_data_replica.`key`, opd.pops_data_replica.value) as properties
FROM opd.pops_data_replica as pops_data_replica
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

  dimension: activity_plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.activity-plan"));;}
  dimension: bmi {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.bmi"));;}
  dimension: bmi_1 {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.bmi-1"));;}
  dimension: choose_your_eating_plan_female {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.choose-your-eating-plan-female"));;}
  dimension: choose_your_eating_plan_french {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.choose-your-eating-plan-french"));;}
  #dimension: choose-your-eating-plan-german-version {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.choose-your-eating-plan-german-version"));;}
  #dimension: choose-your-eating-plan-male {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.choose-your-eating-plan-male"));;}
  #dimension: choose-your-physical-activity-plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.choose-your-physical-activity-plan"));;}
  #dimension: choosing-your-physical-activity-plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.choosing-your-physical-activity-plan"));;}
  #dimension: consent-to-share-data-with-your-gp-practice {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.consent-to-share-data-with-your-gp-practice"));;}
  #dimension: driver {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.driver"));;}
  #dimension: eating-plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.eating-plan"));;}
  #dimension: employed {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.employed"));;}
  #dimension: ethnic-background-duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.ethnic-background-duk"));;}
  #dimension: ethnicity {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.ethnicity"));;}
  #dimension: family-diabetes-duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.family-diabetes-duk"));;}
  #dimension: gender {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.gender"));;}
  #dimension: gender-duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.gender-duk"));;}
  #dimension: gender-m-f-p {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.gender-m-f-p"));;}
  #dimension: gp-practice {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.gp-practice"));;}
  #dimension: height {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.height"));;}
  #dimension: i-agree {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.i-agree"));;}
  #dimension: insulin-check {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.insulin-check"));;}
  #dimension: language {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.language"));;}
  #dimension: medication {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.medication"));;}
  #dimension: navigator-call-phoenix {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.navigator-call-phoenix"));;}
  #dimension: result-duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.result-duk"));;}
  #dimension: result-score-duk {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.result-score-duk"));;}
  #dimension: smoker {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.smoker"));;}
  #dimension: time-since-diagnosis {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.time-since-diagnosis"));;}
  #dimension: tricky-situations-plan {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.tricky-situations-plan"));;}
  #dimension: tricky-situations-problem {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.tricky-situations-problem"));;}
  #dimension: weight {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.weight"));;}
  #dimension: weight-reminder {sql: JSON_UNQUOTE(JSON_EXTRACT(${properties},"$.weight-reminder"));;}

  set: detail {
    fields: [user_id, properties]
  }
}
