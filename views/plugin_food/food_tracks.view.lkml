view: food_tracks {
  sql_table_name: plugin_food.food_tracks ;;
  drill_fields: [id]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    view_label: "7. Activity Data"
    label: "Food Track Recorded"
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

  dimension: description {
    hidden: yes
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: image_id {
    hidden: yes
    type: number
    sql: ${TABLE}.image_id ;;
  }

  dimension: label_foods {
    view_label: "7. Activity Data"
    label: "Food Track Type"
    type: string
    case: {
      when: {
        sql:  ${TABLE}.label_foods = "red";;
        label: "1. Red"
      }
      when: {
        sql: ${TABLE}.label_foods = "amber" ;;
        label: "2. Amber"
      }
      when: {
        sql: ${TABLE}.label_foods = "green" ;;
        label: "3. Green"
      }
      else: "Not Recorded"
    }
    sql: ${TABLE}.label_foods ;;
  }

  dimension: notes {
    hidden: yes
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: program_id {
    hidden: yes
    type: number
    sql: ${TABLE}.program_id ;;
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
    hidden: yes
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    label: "Count - Food Tracker"
    type: count
    drill_fields: [id, users.id]
  }
}
