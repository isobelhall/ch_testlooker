view: session_end {
# If necessary, uncomment the line below to include explore_source.

# include: "ch_platform_model_1.model.lkml"

    derived_table: {
      explore_source: users {
        column: object_id { field: derived_activity_2.object_id }
        column: object_accessed_date_date { field: derived_activity_2.object_accessed_date_date }
        column: sum_secs_since_last_event { field: derived_activity_2.sum_secs_since_last_event }
        column: max_event { field: derived_activity_2.max_event }
        column: user_disengaged { field: derived_characteristics.is_disengaged }
      }
    }

  dimension: object_id {
    hidden: yes
    primary_key: yes
  }

  dimension: object_accessed_date_date {
    type: date
  }

  dimension: sum_secs_since_last_event {
    hidden: yes
    type: number
  }

  dimension: max_event {
    hidden: yes
    type: number
  }

  dimension: user_disengaged {
    hidden: yes
    label: "User has disengaged"
    description: "From derived_characteristics, has this user disengaged? 1 = yes, 0 = no"
    type: number
  }

  dimension: session_end_point {
    type: yesno
    sql:
    CASE
    WHEN ${sum_secs_since_last_event} > 600 THEN TRUE
    ELSE FALSE
    END;;
  }

  dimension: session_end_point_user_disengaged {
    label: "Is last event for user"
    sql:
    CASE
    WHEN ${sum_secs_since_last_event} > 600 AND ${object_accessed_date_date} = ${max_event} THEN TRUE
    ELSE FALSE
    END;;
  }

 }
