view: LTV_model_base {
  derived_table: {
    explore_source: reporting_cohort_metrics {
      column: event_date {}
      column: days_since_install {}
      column: ad_revenue_per_User {}
      derived_column: D1_ltv {
        sql:  ;;
      }
      filters: {
        field: apps.bundle_id
        value: "com.gezellig.roadcrash"
      }
      filters: {
        field: apps.platform
        value: "ios"
      }
      filters: {
        field: reporting_cohort_metrics.event_date
        value: "60 days"
      }
      filters: {
        field: reporting_cohort_metrics.days_since_install
        value: "0,7,14,30"
      }
    }
  }
  dimension: event_date {
    type: date
  }
  dimension: days_since_install {
    type: number
  }
  dimension: ad_revenue_per_User {
    value_format: "$#,##0.00"
    type: number
  }
}
