view: derived_activity_difference {

  view_label: "7. Activity Data"
  derived_table: {
    sql: SELECT
        derived_activity_tables.ObjectID  AS `id`,
        LAG(derived_activity_tables.ObjectAccessedDate) over (partition by derived_activity_tables.uid order by derived_activity_tables.ObjectAccessedDate)  AS `previous_activity`
      FROM  derived_activity_tables.ObjectAccessedDate  AS object_date
       ;;
      # datagroup_trigger: daily_refresh
      # indexes: ["id"]
    }


    dimension: object_id {
      hidden: yes
      primary_key: yes
      type: number
      sql: ${TABLE}.`id` ;;
    }

    dimension: previous_activity {
      type: date
      sql: ${TABLE}.previous_activity ;;
    }

}
