view: user_3appts {

#BASED ON EXPLORE:
# https://changinghealth.cloud.looker.com/explore/ch_platform_model_1/users?qid=xEQTvnxamQf2zYG2t8hekS

#creates set of users who have attended 3 or more appointments, in their first 12 weeks

    derived_table: {
      explore_source: users {
        column: ppuid {}
        filters: {
          field: appointments.weeks_since_start
          value: "<=12"
        }
        filters: {
          field: appointments.count_attended
          value: ">=3"
        }
        filters: {
          field: users.ppuid
          value: "-NULL"
        }
      }
    }

  dimension: CHUID {
    primary_key: yes
    label: "Users - 3+ appts attended in first 12 weeks"
    sql: ${TABLE}.ppuid ;;
  }

  measure: count {
    label: "Count - Users with 3+ appts in first 12 weeks"
    type: count
  }
}
