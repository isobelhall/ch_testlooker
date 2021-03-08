view: derived_signup_times {
  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: object_value { field: derived_signup_activity.object_value }
      column: invitation_sent_timestamp { field: derived_signup_activity.invitation_sent_timestamp }
      column: activated_account { field: derived_signup_activity.activated_account }
    }
  }
  dimension: ppuid {
    hidden: yes
    label: "CHUID"
    description: "Platform identifier for each participant"
  }
  dimension: object_value {
    hidden: yes
    label: "Value"
  }
  dimension: invitation_sent_timestamp {
    label: "Invitation Sent"
    type: date
  }

  dimension: activated_account {
    label: "Activation"
    type: date
  }

  dimension_group: since_invitation_and_activation {
    group_label: "Signup Activity Time Measures - Invitation to Activation"
    label: "between Invitation Sent and Account Activation"
    description: "When used with CHUID, shows amount of time between this activity and the users account creation"
    type: duration
    intervals: [hour, minute, second]
    sql_start: ${invitation_sent_timestamp} ;;
    sql_end: ${activated_account} ;;
  }

}
