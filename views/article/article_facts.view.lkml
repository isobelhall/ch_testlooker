view: article_facts {

    derived_table: {
      explore_source: users {
        column: ppuid {}
        column: count { field: articles_accessed.count }
        filters: {
          field: articles.type
          value: "article"
        }
      }
    }

    dimension: ppuid {
      primary_key: yes
      hidden: yes
      label: "1. User Account CHUID"
      description: "Platform identifier for each participant"
    }

    dimension: count {
      hidden: yes
      label: "7.1 Activity Data - Articles Count - Articles Accessed"
      type: number
    }

  dimension: has_watched_video {
    label: "Has watched a video"
    description: "Has this participant watched a video?"
    type: yesno
    sql:
    CASE
    WHEN ${count} > 0 THEN TRUE
    ELSE FALSE
    END
    ;;
  }

  }




view: video_facts {

    derived_table: {
      explore_source: users {
        column: ppuid {}
        column: count { field: articles_accessed.count }
        filters: {
          field: articles.type
          value: "video"
        }
      }
    }
    dimension: ppuid {
      primary_key: yes
      hidden: yes
      label: "1. User Account CHUID"
      description: "Platform identifier for each participant"
    }
    dimension: count {
      hidden: yes
      label: "Count of videos watched"
      type: number
    }

  dimension: has_watched_video {
    label: "Has watched a video"
    description: "Has this participant watched a video?"
    type: yesno
    sql:
    CASE
    WHEN ${count} > 0 THEN TRUE
    ELSE FALSE
    END
    ;;
  }

}
