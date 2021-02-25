view: derived_characteristics {


  view_label: "8. Temporary Derived Characteristics"

  #@ISOBEL
  #ACTIVITIES DONE
  derived_table: {
    explore_source: users {
      column: ppuid {}
      column: is_referred {}
      column: first_login {field: logins.first_login}
      column: count_logins {field: logins.count}
      column: is_activated {}
      column: is_deleted {}
      column: days_since_account_created {}
      column: count { field: derived_activity_2.count }
      column: progress { field: progress_statistics.progress }
      column: account_older_than_90_days {}
#      column: max_sessions { field: derived_activity_2.max_sessions }
#      column: days_since_max_event {field: derived_activity_2.days_since_max_event}
      column: count_weight { field: derived_activity_2.count_weight }
      column: count_video { field: derived_activity_2.count_video }
      column: count_steps { field: derived_activity_2.count_steps }
      column: count_goal { field: derived_activity_2.count_goal }
      column: count_food { field: derived_activity_2.count_food }
      column: count_appt { field: derived_activity_2.count_appt }
      column: count_blood_glucose { field: derived_activity_2.count_blood_glucose}
      column: count_reading_room { field: derived_activity_2.count_reading_room}
      column: count_articles { field: derived_activity_2.count_articles }
    }
    #datagroup_trigger:  daily_refresh
    #indexes: ["ppuid"]
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

#ACTIVITY COUNTS, HAVE THEY DONE ACTIVITY? HOW MUCH?
  dimension_group: first_login {
    timeframes: [raw, time, hour_of_day, day_of_week, date, week, month, quarter, year]
    type: time
    drill_fields: [detail*]
  }

  dimension: has_logged_in {
      type: number
      drill_fields: [detail*]
      sql: CASE WHEN (${TABLE}.count_logins > 0) THEN 1 ELSE 0 END ;;
    }

  measure: count_logged_in {
    group_label: "Programme Progress"
    label: "2. Is Enabled"
    type: count
    sql: ${has_logged_in} ;;
  }

    dimension: has_done_activity {
      type: number
      drill_fields: [detail*]
      sql: CASE WHEN (${TABLE}.count > 0) THEN 1 ELSE 0 END ;;
    }

    dimension: has_done_activity_yesno {
      type: yesno
      drill_fields: [detail*]
      sql: CASE WHEN (${TABLE}.count > 0) THEN TRUE ELSE FALSE END ;;
    }

##15/02/21 - CHANGED FROM Yesno to Number (1 = true, 0 = false) Test and revert if fails
  #activity types
  dimension: has_done_articles {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_articles > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }
  dimension: has_done_video {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_video > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }
  dimension: has_done_steps {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_steps > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }
  dimension: has_done_weight {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_weight > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }
  dimension: has_done_goal {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_goal > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }
  dimension: has_done_food {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_food > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }
  dimension: has_done_appt {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_appt > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }

  dimension: has_done_blood_glucose {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_blood_glucose > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }

  dimension: has_done_reading_room {
    group_label: "Activity Breakdown"
    type: number
    sql: CASE WHEN (${TABLE}.count_reading_room > 0) THEN 1 ELSE 0 END ;;
    drill_fields: [detail*]
  }


  #HAS OPENED ACCOUNT/BEEN REFERRED
  dimension: is_referred {
    group_label: "Programme Progress"
    label: "1. Accounts Created"
    type: number
    drill_fields: [detail*]
  }

  measure: count_referred {
    group_label: "Programme Progress - Counts"
    label: "Count - Referred"
    type: sum
    drill_fields: [detail*]
    sql: ${is_referred} ;;
  }

  #HAS ACTIVATED
  dimension: is_activated{
    group_label: "Programme Progress"
    label: "2. Is Enabled"
    type: number
    drill_fields: [detail*]
  }

  measure: count_activated {
    group_label: "Programme Progress - Counts"
    label: "Count - Has Activated"
    type: sum
    drill_fields: [detail*]
    sql: ${is_activated} ;;
  }

  measure: percent_activated {
    group_label: "Programme Progress - Percent"
    label: "Percent - Has Activated"
    description: "Percent of accounts that have been activated, out of all referrals"
    type: number
    value_format: "0.0%"
    drill_fields: [detail*]
    sql: ${count_activated} / ${count_referred} * 100 ;;
  }

  #HAS ENGAGED
  dimension: has_engaged{
    group_label: "Programme Progress"
    label: "3a. Has Engaged"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${has_done_activity} = 1) THEN 1 ELSE 0 END ;;
  }

  measure: count_engaged {
    label: "Count - Engaged"
    group_label: "Programme Progress - Counts"
    type: sum
    drill_fields: [detail*]
    sql: ${has_engaged} ;;
  }

  measure: percent_engaged {
    group_label: "Programme Progress - Percent"
    label: "Percent - Engaged"
    description: "Percent of accounts that have engaged (completed an activity), out of all activated accounts"
    type: number
    drill_fields: [detail*]
    sql: ${count_engaged} / ${count_activated} * 100 ;;
  }


  #HAS COMPLETED (100%)
  dimension: has_completed_100 {
  group_label: "Programme Progress"
  label: "4a. Completed (100%)"
  type: number
  drill_fields: [detail*]
  sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${has_done_activity} = 1 and ${TABLE}.progress >= 1) THEN 1 ELSE 0 END ;;
}

  measure: count_completed_100 {
    label: "Count - Completed (100%)"
    group_label: "Programme Progress - Counts"
    type: sum
    drill_fields: [detail*]
    sql: ${has_completed_100} ;;
  }

  measure: percent_completed_100 {
    group_label: "Programme Progress - Percent"
    label: "Percent - Completed (100%)"
    description: "Percent of accounts that have engaged (completed an activity), out of all activated accounts"
    type: number
    drill_fields: [detail*]
    sql: ${count_completed_100} / ${count_activated} * 100 ;;
  }

  #HAS COMPLETED (60% - HL standard)
  dimension: has_completed_60 {
    group_label: "Programme Progress"
    label: "4b. Completed (60% - HL)"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${has_done_activity} = 1 and ${TABLE}.progress >= 0.6) THEN 1 ELSE 0 END ;;
  }

  measure: count_completed_60 {
    label: "Count - Completed (60% - HL)"
    group_label: "Programme Progress - Counts"
    type: sum
    drill_fields: [detail*]
    sql: ${has_completed_60} ;;
  }

  measure: percent_completed_60 {
    group_label: "Programme Progress - Percent"
    label: "Percent - Completed (60% - HL)"
    description: "Percent of accounts that have engaged (completed an activity), out of all activated accounts"
    type: number
    drill_fields: [detail*]
    sql: ${count_completed_60} / ${count_activated} * 100 ;;
  }

###
# CURRENT STATUS
###

  #dimension: engaged - used in current status measures
  #WAS ACTIVE IN LAST 90 DAYS (DAYS SINCE LAST ACTIVITY IS LESS THAN 90)
  dimension: account_older_than_90_days {
    hidden: yes
    type: number
    drill_fields: [detail*]
  }

  dimension: is_account_older_than_90_days {
    hidden: yes
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${TABLE}.account_older_than_90_days >0 ) THEN 1 ELSE 0 END ;;
  }


  #IS ACTIVE BUT NOT YET ENGAGED AND YOUNGER THAN 90 DAYS
  dimension: is_inactive{
    group_label: "Current Status"
    label: "0. Activated, not yet engaged"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${has_done_activity} = 0 and ${TABLE}.account_older_than_90_days <= 90) THEN 1 ELSE 0 END ;;
  }

  measure: count_inactive {
    group_label: "Current Status - Counts"
    label: "0. Count - Activated, not yet engaged"
    type: sum
    drill_fields: [detail*]
    sql: ${is_inactive} ;;
  }

  measure: percent_inactive {
    group_label: "Current Status - Percent"
    label: "0. Percent - Activated, not yet engaged"
    description: "Percent of people who have not done any activity and become 'engaged', but created their account within the last 90 days. "
    type: number
    drill_fields: [detail*]
    sql: ${count_inactive} / ${count_activated} * 100 ;;
  }


  #IS DISENGAGED AFTER ACTIVATING (NO ACTIVITY AND OLDER THAN 90 DAYS)
  dimension: is_inactive_disengaged{
    group_label: "Current Status"
    label: "3a. Activated, disengaged"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${has_done_activity} = 0 and ${TABLE}.account_older_than_90_days > 90) THEN 1 ELSE 0 END ;;
  }

  measure: count_inactive_disengaged {
    group_label: "Current Status - Counts"
    label: "3a. Count - Activated, disengaged"
    type: sum
    drill_fields: [detail*]
    sql: ${is_inactive_disengaged} ;;
  }

  measure: percent_inactive_disengaged {
    group_label: "Current Status - Percent"
    label: "3a. Percent - Activated, disengaged"
    description: "Percent of people who have not done any activity to 'engaged' in 90 days since creating an account."
    type: number
    drill_fields: [detail*]
    sql: ${count_inactive_disengaged} / ${count_activated} * 100 ;;
  }


  #IS CURRENTLY ENGAGED
  dimension: is_engaged{
    group_label: "Current Status"
    label: "1. Is Engaged"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${has_done_activity} = 1 and ${TABLE}.days_since_max_event < 90) THEN 1 ELSE 0 END ;;
  }

  measure: count_is_engaged {
    group_label: "Current Status - Counts"
    label: "2. Count - Is Engaged"
    type: sum
    drill_fields: [detail*]
    sql: ${is_engaged} ;;
  }

  measure: percent_is_engaged {
    group_label: "Current Status - Percent"
    label: "2. Percent - Is Engaged"
    type: number
    drill_fields: [detail*]
    sql: ${count_is_engaged} / ${count_activated} * 100 ;;
  }


  #IS CURRENTLY DISENGAGED
  dimension: is_disengaged{
    group_label: "Current Status"
    label: "2. Is Disengaged"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${TABLE}.is_referred = 1 AND ${TABLE}.is_activated = 1 AND ${has_done_activity} = 1 and ${TABLE}.days_since_max_event > 90) THEN 1 ELSE 0 END ;;
  }

  measure: count_is_disengaged {
    group_label: "Current Status - Counts"
    label: "2. Count - Is Disengaged"
    type: sum
    drill_fields: [detail*]
    sql: ${is_disengaged} ;;
  }

  measure: percent_is_disengaged {
    group_label: "Current Status - Percent"
    label: "2. Percent - Is Disengaged"
    type: number
    drill_fields: [detail*]
    sql: ${count_is_disengaged} / ${count_activated} * 100 ;;
  }


  #IS DISENGAGED AFTER ONE SESSION
  dimension: disengaged_after_one_session{
    group_label: "Current Status"
    label: "3b. Disengaged after one session"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_disengaged} = 1 AND ${TABLE}.max_sessions = 1) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_after_one_session {
    group_label: "Current Status - Counts"
    label: "3b. Count - Disengaged after one session"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_after_one_session} ;;
  }

  measure: percent_disengaged_after_one_session {
    group_label: "Current Status - Percent"
    label: "3b. Percent - Disengaged after one session"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_after_one_session} / ${count_activated} * 100 ;;
  }


  #DISENGAGED NO ACTIVITY
  dimension: disengaged_no_activity{
    group_label: "Current Status"
    label: "3c. Disengaged, no activity"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_disengaged} = 1 AND ${TABLE}.max_sessions = 0) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_no_activity {
    group_label: "Current Status - Counts"
    label: "3c. Count - Disengaged, no activity"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_no_activity} ;;
  }

  measure: percent_disengaged_no_activity {
    label: "3c. Percent - Disengaged, no activity"
    group_label: "Current Status - Percent"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_no_activity} / ${count_activated} * 100 ;;
  }


  #IS DISENGAGED (no activity in 90 days) WITH ONE OR MORE SESSIONS, AND PROGRESS LESS THAN 25%
  dimension: disengaged_under_25pct{
    group_label: "Current Status"
    label: "3d. Disengaged under 25%"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_disengaged} = 1 AND ${TABLE}.max_sessions >= 1 and ${TABLE}.progress < 0.25) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_under_25pct {
    group_label: "Current Status - Counts"
    label: "3d. Count - Disengaged under 25%"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_under_25pct} ;;
  }

  measure: percent_disengaged_up_to_25pct {
    label: "3d. Percent - Disengaged under 25%"
    group_label: "Current Status - Percent"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_under_25pct} / ${count_activated} * 100 ;;
  }


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 25%, LESS THAN 50%
  dimension: disengaged_up_to_50pct{
    group_label: "Current Status"
    label: "3e. Disengaged between 25% and 50%"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_disengaged} = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions > 1 and ${TABLE}.progress >= 0.25 and ${TABLE}.progress < 0.50) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_up_to_50pct {
    group_label: "Current Status - Counts"
    label: "3e. Count - Disengaged between 25% and 50%"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_up_to_50pct} ;;
  }

  measure: percent_disengaged_up_to_50pct {
    label: "3e. Percent - Disengaged between 25% and 50%"
    group_label: "Current Status - Percent"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_up_to_50pct} / ${count_activated} * 100 ;;
  }


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 50%, LESS THAN 60%
  dimension: disengaged_up_to_60pct{
    group_label: "Current Status"
    label: "3f. Disengaged between 50% and 60%"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_disengaged} = 1 and ${TABLE}.days_since_max_event > 90  AND ${TABLE}.max_sessions > 1 and ${TABLE}.progress >= 0.50 and ${TABLE}.progress < 0.60) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_up_to_60pct {
    group_label: "Current Status - Counts"
    label: "3f. Count - Disengaged between 50% and 60%"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_up_to_60pct} ;;
  }

  measure: percent_disengaged_up_to_60pct {
    label: "3f. Percent - Disengaged between 50% and 60%"
    group_label: "Current Status - Percent"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_up_to_60pct} / ${count_activated} * 100 ;;
  }


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 60%, LESS THAN 75%
  dimension: disengaged_up_to_75pct{
    group_label: "Current Status"
    label: "3g. Disengaged between 60% and 75%"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_disengaged} = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions > 1 and ${TABLE}.progress >= 0.60 and ${TABLE}.progress < 0.75) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_up_to_75pct {
    group_label: "Current Status - Counts"
    label: "3g. Count - Disengaged between 60% and 75%"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_up_to_75pct} ;;
  }

  measure: percent_disengaged_up_to_75pct {
    label: "3g. Percent - Disengaged between 60% and 75%"
    group_label: "Current Status - Percent"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_up_to_75pct} / ${count_activated} * 100 ;;
  }


  #IS DISENGAGED WITH ONE OR MORE SESSIONS, AND PROGRESS GREATER THAN 75%, LESS THAN 100%
  dimension: disengaged_up_to_100pct{
    group_label: "Current Status"
    label: "3h. Disengaged between 75% and 100%"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_disengaged} = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions > 1 and ${TABLE}.progress >= 0.75 and ${TABLE}.progress < 1) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_up_to_100pct {
    group_label: "Current Status - Counts"
    label: "3h. Count - Disengaged between 75% and 100%"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_up_to_100pct} ;;
  }

  measure: percent_disengaged_up_to_100pct {
    label: "3h. percent - Disengaged between 75% and 100%"
    group_label: "Current Status - Percent"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_up_to_100pct} / ${count_activated} * 100 ;;
  }



####### DISENGAGED AFTER COMPLETING
  dimension: disengaged_after_completion100{
    label: "4a. Disengaged, 100% Completion"
    group_label: "Current Status"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${is_engaged} = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions > 1 and ${TABLE}.progress >= 1) THEN 1 ELSE 0 END ;;
  }

  measure: count_disengaged_after_completion100 {
    label: "4a. Count - Disengaged, 100% Completion"
    group_label: "Current Status - Counts"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_after_completion100} ;;
  }

  measure: percent_disengaged_after_completion100 {
    label: "4a. Percent - Disengaged, 100% Completion"
    group_label: "Current Status - Percent"
    description: "Percent of accounts that have reached 100% completion, out of all referrals"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_after_completion100} / ${count_activated} * 100 ;;
  }


  dimension: disengaged_after_completion60{
    label: "4b. Disengaged, 60% Completion"
    group_label: "Current Status"
    type: number
    drill_fields: [detail*]
    sql: CASE WHEN (${has_engaged} = 1 and ${TABLE}.days_since_max_event > 90 AND ${TABLE}.max_sessions > 1 and ${TABLE}.progress >= 0.60) THEN 1 ELSE 0 END ;;
  }


  measure: count_disengaged_after_completion60 {
    label: "4b. Count - Disengaged, 60% Completion"
    group_label: "Current Status - Counts"
    type: sum
    drill_fields: [detail*]
    sql: ${disengaged_after_completion60} ;;
  }

  measure: percent_disengaged_after_completion60 {
    label: "4b. Percent - Disengaged, 60% Completion"
    group_label: "Current Status - Percent"
    description: "Percent of accounts that have reached 60% completion, out of all referrals"
    type: number
    drill_fields: [detail*]
    sql: ${count_disengaged_after_completion60} / ${count_activated} * 100;;
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



# ----- Sets of fields for drilling ------
set: detail {
  fields: [
    ppuid,
  ]
  }
}
