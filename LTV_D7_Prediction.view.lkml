datagroup: prediction_trigger_d7 {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

view: training_input_d7 {
  derived_table: {
    explore_source: reporting_cohorted_revenue {
      column: date {field:reporting_cohorted_revenue.date}
      column: bundle_id {field: apps.bundle_id}
      column: platform {field: reporting_cohorted_revenue.platform}
      column: installs {field: reporting_metrics.tracked_installs}
      column: revenue_d1 {}
      column: revenue_d2 {}
      column: revenue_d3 {}
      column: revenue_d4 {}
      column: revenue_d5 {}
      column: revenue_d6 {}
      column: revenue_d7 {}
      filters: {
        field: reporting_cohorted_revenue.date
        value: "60 days ago for 30 days"
        # value: "60 days ago for 30 days"
      }
    }
  }
}

######################## MODEL #############################


view: future_revenue_model_d7 {
  derived_table: {
    datagroup_trigger: prediction_trigger
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      OPTIONS(model_type='linear_reg'
        , input_label_cols=['revenue_d7']
        ) AS
      SELECT
         * EXCEPT(date, bundle_id,platform)
      FROM ${training_input_d7.SQL_TABLE_NAME};;
  }
}

########################################## PREDICT FUTURE ############################

view: future_input_d7 {
  derived_table: {
    explore_source: reporting_cohorted_revenue {
      column: date { field:reporting_cohorted_revenue.date}
      column: bundle_id {field: apps.bundle_id}
      column: platform {field: reporting_cohorted_revenue.platform}
      column: installs {field: reporting_metrics.tracked_installs}
      column: revenue_d1 {}
      column: revenue_d2 {}
      column: revenue_d3 {}
      column: revenue_d4 {}
      column: revenue_d5 {}
      column: revenue_d6 {}
      filters: {
        field: reporting_cohorted_revenue.date
        value: "30 days"
      }
    }
  }
}


view: future_revenue_prediction_d7 {
  derived_table: {
    sql: SELECT * FROM ml.PREDICT(
          MODEL ${future_revenue_model_d7.SQL_TABLE_NAME},
          (SELECT * FROM ${future_input_d7.SQL_TABLE_NAME}));;
  }
  #measure: predicted_revenue_d7{type:sum}
  measure: revenue_d1{type: sum}
  measure: revenue_d2{type: sum}
  measure: revenue_d3{type: sum}
  measure: revenue_d4{type: sum}
  measure: revenue_d5{type: sum}
  measure: revenue_d6{type: sum}
  measure: predicted_revenue_d7{type: sum}


  dimension: date {type: date}
  dimension: bundle_id {type: string}
  dimension: platform {type: string}
  measure: installs{type:sum}


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
