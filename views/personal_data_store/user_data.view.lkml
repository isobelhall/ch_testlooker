view: user_data {
  sql_table_name: personal_data_store.user_data ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: birthdate {
    view_label: "3. Identifiables"
    label: "Birthdate"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.birthdate ;;
  }

  dimension: age {
    view_label: "3. Identifiables"
    label: "Age"
    type: number
    value_format: ""
    sql: FLOOR(DATEDIFF(now(), ${birthdate_date}) / 365.25) ;;
  }

  dimension: age_group {
    type: tier
    tiers: [0,18,25,30,35,40,45,50,55,60,65,70,75,80]
    style: integer
    sql: ${age} ;;
  }

  measure: avg_age {
    type: average_distinct
    sql_distinct_key: ${id} ;;
    sql: ${age} ;;
    value_format: "#"
  }

  dimension_group: created {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: deleted {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.deleted_at ;;
  }

  dimension: distance_unit {
    hidden: yes
    type: number
    sql: ${TABLE}.distance_unit ;;
  }

  dimension: email {
    view_label: "3. Identifiables"
    label: "Email"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    view_label: "3. Identifiables"
    label: "First Name"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: landline_phone {
    view_label: "3. Identifiables"
    label: "Landline Number"
    type: string
    sql: ${TABLE}.landline_phone ;;
  }

  dimension: last_name {
    view_label: "3. Identifiables"
    label: "Last Name"
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: meta {
    hidden: yes
    type: string
    sql: ${TABLE}.meta ;;
  }

  dimension: new_email {
    hidden: yes
    type: string
    sql: ${TABLE}.new_email ;;
  }

  dimension: phone {
    view_label: "3. Identifiables"
    label: "Mobile Phone"
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: sys_first_name {
    view_label: "3. Identifiables"
    label: "System First Name"
    type: string
    sql: ${TABLE}.sys_first_name ;;
  }

  dimension: sys_last_name {
    view_label: "3. Identifiables"
    label: "System Last Name"
    type: string
    sql: ${TABLE}.sys_last_name ;;
  }

  # Concatenate first and last name for user

  dimension: full_name {
    description: "The first and last name for user"
    view_label: "3. Identifiables"
    label: "Full Name"
    type: string
    sql: CONCAT(${TABLE}.sys_first_name,' ', ${TABLE}.sys_last_name) ;;
  }

  dimension_group: updated {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      sys_first_name,
      sys_last_name,
      users.id
    ]
  }
}
