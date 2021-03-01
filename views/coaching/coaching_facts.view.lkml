view: coaching_facts {

# If necessary, uncomment the line below to include explore_source.

# include: "ch_platform_model_1.model.lkml"

    derived_table: {
      explore_source: users {
        column: ppuid {}
        column: count { field: appointments.count }
        column: count_attended { field: appointments.count_attended }
        column: count_cancelled { field: appointments.count_cancelled }
        column: percent_attended { field: appointments.percent_attended }

      }
    }
    dimension: count {
      label: "Appt Count"
      type: number
    }
    dimension: count_attended {
      label: "6. Coaching Count - Appointments Attended"
      type: number
    }
    dimension: count_cancelled {
      label: "6. Coaching Count - Appointments Cancelled"
      type: number
    }
    dimension: percent_attended {
      label: "6. Coaching Count - Percent Appointments Attended"
      value_format: "#,##0.0%"
      type: number
    }
    dimension: ppuid {
      label: "0. General Users - 3+ appts attended in first 12 weeks"
    }

    measure: average_DNA_rate {
      type: average
      sql: ${percent_attended} ;;
    }

}
