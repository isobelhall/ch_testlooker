view: derived_characteristics {


  view_label: "8. Temporary Derived Characteristics"


  #ACTIVITIES DONE
  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: is_referred {}
      column: is_activated {}
      column: is_deleted {}
      column: days_since_account_created {}
      column: count { field: derived_activity_2.count }
      column: progress { field: progress_statistics.progress }
      column: account_older_than_90_days {}
      column: max_sessions { field: derived_activity_2.max_sessions }
      column: days_since_max_event {field: derived_activity_2.days_since_max_event}
    }
  }

#REMOVED FROM DERIVED TABLE ABOVE
#  column: has_done_activity { field: derived_activity_2.has_done_activity }

#DIMENSIONS
    dimension: ppuid {
      hidden: yes
      label: "CHUID"
      description: "Platform identifier for each participant"
    }

  dimension: days_since_max_event {
    label: "Days since latest Activity"
    description: "Number of days since participant last did something in activity table"
  }

    dimension: count {
      label: "Activities Completed Per User"
      type: number
    }

    dimension: has_done_activity {
      type: number
      sql: CASE WHEN (${TABLE}.count > 0) THEN 1 ELSE 0 END ;;
    }

  #dimension: engaged
  #WAS ACTIVE IN LAST 90 DAYS (DAYS SINCE LAST ACTIVITY IS LESS THAN 90)
  dimension: account_older_than_90_days {
    hidden: yes
    type: number
  }

  dimension: is_account_older_than_90_days {
    hidden: yes
    type: number
    sql: CASE WHEN (${TABLE}.account_older_than_90_days >0 ) THEN 1 ELSE 0 END ;;
  }

  #iS ENGAGED
  dimension: is_engaged{
    label: "3a. Is Engaged"
    type: number
    sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${TABLE}.has_done_activity = 1) THEN 1 ELSE 0 END ;;
  }

  #IS DISENGAGED AFTER ONE SESSION
  dimension: disengaged_after_one_session{
    label: "3b. Disengaged after one session"
    type: number
    sql: CASE WHEN (${TABLE}.is_engaged = 1 AND ${TABLE}.max_sessions = 1) THEN 1 ELSE 0 END ;;
  }

  #IS DISENGAGED (no activity in 90 days) WITH ONE OR MORE SESSIONS, AND PROGRESS LESS THAN 25%
  dimension: disengaged_after_25pct{
    label: "3c. Disengaged after 25%"
    type: number
    sql: CASE WHEN (${TABLE}.is_engaged = 1 AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress < 0.25) THEN 1 ELSE 0 END ;;
  }

  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 25%, LESS THAN 50%
  dimension: disengaged_after_50pct{
    label: "3c. Disengaged between 25% and 50%"
    type: number
    sql: CASE WHEN (${TABLE}.is_engaged = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress >= 0.25 and ${TABLE}.progress < 0.50) THEN 1 ELSE 0 END ;;
  }

  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 50%, LESS THAN 60%
  dimension: disengaged_after_60pct{
    label: "3d. Disengaged between 50% and 60%"
    type: number
    sql: CASE WHEN (${TABLE}.is_engaged = 1 and ${TABLE}.days_since_max_event > 90  AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress >= 0.50 and ${TABLE}.progress < 0.60) THEN 1 ELSE 0 END ;;
  }

  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 75%, LESS THAN 100%
  dimension: disengaged_after_100pct{
    label: "3f. Disengaged between 60% and 75%"
    type: number
    sql: CASE WHEN (${TABLE}.is_engaged = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress >= 0.60 and ${TABLE}.progress < 0.75) THEN 1 ELSE 0 END ;;
  }


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 100%
  dimension: disengaged_after_76pct{
    label: "3g. Disengaged between 75% and 100%"
    type: number
    sql: CASE WHEN (${TABLE}.is_engaged = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress >= 0.75 and ${TABLE}.progress < 1) THEN 1 ELSE 0 END ;;
  }


#IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 100%
dimension: disengaged_after_completion100{
  label: "5. Disengaged after completion (100%)"
  type: number
  sql: CASE WHEN (${TABLE}.is_engaged = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress >= 1) THEN 1 ELSE 0 END ;;
}

  dimension: disengaged_after_completion60{
    label: "5. Disengaged after completion (60% - HL)"
    type: number
    sql: CASE WHEN (${TABLE}.is_engaged = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress >= 0.60) THEN 1 ELSE 0 END ;;
  }
}

  #DAYS SINCE ACCOUNT CREATED
    #users.days_since_account_created <-tested, complete

  #ACCOUNT OLDER THAN 90 DAYS
    #users.account_older_than_90_days <-tested, complete


  #DAYS SINCE FIRST ACTIVITY
  #  derived_activity_2.min_event
  #needs days

  #DAYS SINCE LAST ACTIVITY
  #  derived_activity_2.max_event
  #need days

  #SESSION COUNT
    #found in derived_activity_2.max_sessions <-tested, complete


  #IS REFERRED
    #users.is_referred

  #IS ACTIVATED
    #users.is_activated

  #IS ENGAGED (IS ACTIVATED AND ACTIVITIES DONE IS GREATER THAN ONE AND LAST ACTIVITY WAS LESS THAN 90 DAYS AGO
    #is referred, is activated, has done an activity

  #IS DELETED
    #users.is_deleted

  #WAS ACTIVE IN LAST 90 DAYS (DAYS SINCE LAST ACTIVITY IS LESS THAN 90)



  #TIME SPENT ON PLATFORM (sum of all times found in derived_ativity_2 for this ppt ID)


  #TIME SPENT in articles (sum of all times found in derived_ativity_2 for this ppt ID)

  #TIME SPENT in videos (sum of all times found in derived_ativity_2 for this ppt ID)

  #TIME SPENT in step tracker (sum of all times found in derived_ativity_2 for this ppt ID)

  #TIME SPENT in weight tracker (sum of all times found in derived_ativity_2 for this ppt ID)

  #TIME SPENT in articles (sum of all times found in derived_ativity_2 for this ppt ID)

  #TIME SPENT in other plugin (sum of all times found in derived_ativity_2 for this ppt ID)

  #TIME SPENT in goal (sum of all times found in derived_ativity_2 for this ppt ID)

  #TIME SPENT in food (sum of all times found in derived_ativity_2 for this ppt ID)


  #COUNT OF ARTICLES READ

  #COUNT OF VIDEOS WATCHED




  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
#}

# view: derived_characteristics {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
