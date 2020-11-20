datagroup: prediction_trigger_d30 {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

view: training_input_d30 {
  derived_table: {
    explore_source: reporting_cohorted_revenue {
      column: date {field:reporting_cohorted_revenue.date}
      column: bundle_id {field: apps.bundle_id}
      column: platform {field: reporting_cohorted_revenue.platform}
      # column: installs {field: reporting_metrics.tracked_installs}
      column: revenue_d1 {}
      #column: rep_spend {field: reporting_metrics.rep_spend}
      column: impressions {field: reporting_metrics.rep_impressions}
      #column: cpi {field: reporting_metrics.CPI}
      # column: dau {field: reporting_metrics.DAU}
      #column: arpdau {field:reporting_metrics.Ad_ARPDAU}
      column: revenue_d30 {}
      filters: {
        field: reporting_cohorted_revenue.date
        value: "30 days ago for 28 days"
        # value: "60 days ago for 30 days"
      }
    }
  }
}

######################## MODEL #############################


view: future_revenue_model_d30 {
  derived_table: {
    datagroup_trigger: prediction_trigger
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      OPTIONS(model_type='linear_reg'
        , input_label_cols=['revenue_d30']

        ) AS
      SELECT
         * EXCEPT( bundle_id,platform)
      FROM ${training_input_d30.SQL_TABLE_NAME};;
  }
}

########################################## PREDICT FUTURE ############################

view: future_input_d30 {
  derived_table: {
    explore_source: reporting_cohorted_revenue {
      column: date { field:reporting_cohorted_revenue.date}
      column: bundle_id {field: apps.bundle_id}
      column: platform {field: reporting_cohorted_revenue.platform}
      # column: installs {field: reporting_metrics.tracked_installs}
      #column: rep_spend {field: reporting_metrics.rep_spend}
      column: impressions {field: reporting_metrics.rep_impressions}
      #column: cpi {field: reporting_metrics.CPI}
      # column: dau {field: reporting_metrics.DAU}
      #column: clicks {field: reporting_metrics.reported_clicks}
      #column: arpdau {field:reporting_metrics.Ad_ARPDAU}
      column: revenue_d1 {}
      filters: {
        field: reporting_cohorted_revenue.date
        value: "30 days"
      }
    }
  }
}


view: future_revenue_prediction_d30 {
  derived_table: {
    sql: SELECT * FROM ml.PREDICT(
          MODEL ${future_revenue_model_d30.SQL_TABLE_NAME},
          (SELECT * FROM ${future_input_d30.SQL_TABLE_NAME}));;
  }
  #measure: predicted_revenue_d7{type:sum}
  #measure: revenue_d1{type: sum}
  measure: predicted_revenue_d30{type: sum}
  measure: impressions {type:sum}
  #measure: rep_spend {type:sum}
  #measure: cpi {type:sum}
  # measure: dau {type:sum}
  #measure: arpdau {type:sum}
  #measure: clicks {type:sum}

  dimension: date {type: date}
  dimension: bundle_id {type: string}
  dimension: platform {type: string}
  # measure: installs{type:sum}


  # measure: max_predicted_score {
  #   type: max
  #   value_format_name: percent_2
  #   sql: ${predicted_revenue_d14} ;;
  # }
  # measure: average_predicted_score {
  #   type: average
  #   value_format_name: percent_2
  #   sql: ${predicted_revenue_d14} ;;
  # }
}
