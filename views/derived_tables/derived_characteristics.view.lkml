view: derived_characteristics {


  view_label: "2. Demographics / User Attributes"

  #ACTIVITIES DONE


  #DAYS SINCE ACCOUNT CREATED
    #users.days_since_account_created


  #DAYS SINCE FIRST ACTIVITY


  #DAYS SINCE LAST ACTIVITY

  #SESSION COUNT
    #found in derived_activity_2.max_sessions

  #IS REFERRED

  #IS ACTIVATED

  #IS DELETED


  #WAS ACTIVE IN LAST 90 DAYS (DAYS SINCE LAST ACTIVITY IS LESS THAN 90)


  #IS ENGAGED (IS ACTIVATED AND ACTIVITIES DONE IS GREATER THAN ONE AND LAST ACTIVITY WAS LESS THAN 90 DAYS AGO



  #IS DISENGAGED AFTER ONE SESSION


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS LESS THAN 25%


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 25%, LESS THAN 50%


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 25%, LESS THAN 50%


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 50%, LESS THAN 60%


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 60%




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
}

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