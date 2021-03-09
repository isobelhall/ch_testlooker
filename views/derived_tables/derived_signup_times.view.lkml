view: derived_signup_times {



  derived_table: {
    explore_source: users {
      column: uid { field: derived_signup_activity.uid }
      column: invitation_sent_timestamp { field: flattened_invitation.invitation_sent_timestamp }
      column: activated_account { field: flattened_activation.activation_timestamp }
    }
  }

  dimension: uid {
    primary_key: yes
    hidden: yes
    label: "CHUID"
    description: "Platform identifier for each participant"
  }

  dimension: invitation_sent_timestamp {
    hidden: yes
    type: date_time
  }

  dimension: activated_account {
    hidden: yes
    type: date_time
  }

  dimension_group: time_to_activation_from_invitation_TEST {
    type: duration
    timeframes: [date, hour, minute, second]
    sql_start: ${invitation_sent_timestamp} ;;
    sql_end: ${activated_account} ;;
  }

#  dimension: buckets_days_to_activation_from_invitation_TEST {
#    type: tier
#    tiers: [0,1]
#    sql: ${hours_time_to_activation_from_invitation_TEST} ;;
#  }

  dimension: buckets_days_to_activation_from_invitation_TEST {
    case: {
      when: {
        sql: ${hours_time_to_activation_from_invitation_TEST} < 24;;
        label: "Activated within 24 hours"
      }
      when: {
        sql: ${hours_time_to_activation_from_invitation_TEST} >= 0;;
        label: "Activated after 24 hours"
      }
      else:"Not Activated"
    }
  }


#  measure: time_to_activation_from_invitation_TEST {
#    type: date_time
#    sql: DATEDIFF(${activated_account}, ${invitation_sent_timestamp}) ;;
#  }
}

# If necessary, uncomment the line below to include explore_source.

# include: "ch_platform_model_1.model.lkml"

view: flattened_invitation {
  derived_table: {
    explore_source: users {
      column: uid { field: derived_signup_activity.uid }
      column: object_value { field: derived_signup_activity.object_value }
      column: invitation_sent_timestamp { field: derived_signup_activity.invitation_sent_timestamp }
      filters: {
        field: derived_signup_activity.object_type
        value: "status change"
      }
      filters: {
        field: derived_signup_activity.object_value
        value: "invitation_sent"
      }
      }
        }

      dimension: uid {
        primary_key: yes
        hidden: yes
        label: "CHUID"
        description: "Platform identifier for each participant"
      }

      dimension: object_value {
        hidden: yes
        label: ""
      }

      dimension: been_invited {
        hidden: yes
        type: yesno
        sql:
        CASE WHEN ${invitation_sent_timestamp} > 0 then TRUE
        ELSE FALSE
        END;;
        label: "TEST_ User Invited"
      }

      dimension: invitation_sent_timestamp {
        label: "TEST_ Invitation_Timestamp"
        type: date_time
      }
    }

view: flattened_activation {
  derived_table: {
    explore_source: users {
      column: uid { field: derived_signup_activity.uid }
      column: object_value { field: derived_signup_activity.object_value }
      column: activation_timestamp { field: derived_signup_activity.activated_account }
      filters: {
        field: derived_signup_activity.object_type
        value: "status change"
      }
      filters: {
        field: derived_signup_activity.object_value
        value: "completed_activation"
      }
    }
  }

  dimension: uid {
    primary_key: yes
    hidden: yes
    label: "CHUID"
    description: "Platform identifier for each participant"
  }

  dimension: object_value {
    hidden: yes
    label: "7a. Sign Up Activity Data Sign Up Activities - Value"
  }

  dimension: activation_timestamp {
    label: "TEST_Activation_Timestamp"
    type: date_time
  }

}
