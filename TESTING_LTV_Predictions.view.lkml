datagroup: prediction_trigger {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

view: training_input {
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
      column: revenue_d14 {}
      filters: {
        field: apps.bundle_id
        value: "com.gezellig.roadcrash"
      }
      filters: {
        field: apps.platform
        value: "ios"
      }
      filters: {
        field: reporting_metrics.date_date
        value: "60 days ago for 30 days"
      }
    }
  }
}

view: testing_input {
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
      column: revenue_d14 {}
      filters: {
        field: apps.bundle_id
        value: "com.gezellig.roadcrash"
      }
      filters: {
        field: apps.platform
        value: "ios"
      }
      filters: {
        field: reporting_metrics.date_date
        value: "30 days ago for 21 days"
      }
    }
  }
}

######################## MODEL #############################


view: future_revenue_model {
  derived_table: {
    datagroup_trigger: prediction_trigger
    sql_create:
      CREATE OR REPLACE MODEL ${SQL_TABLE_NAME}
      OPTIONS(model_type='linear_reg'
        , labels=['revenue_d14']
        ) AS
      SELECT
         * EXCEPT(date, bundle_id,platform)
      FROM ${training_input.SQL_TABLE_NAME};;
  }
}


######################## TRAINING INFORMATION #############################
explore:  future_revenue_model_evaluation {}
explore: future_revenue_model_training_info {}
explore: roc_curve {}

# VIEWS:
view: future_revenue_model_evaluation {
  derived_table: {
    sql: SELECT * FROM ml.EVALUATE(
          MODEL ${future_revenue_model.SQL_TABLE_NAME},
          (SELECT * FROM ${testing_input.SQL_TABLE_NAME}));;
  }
  dimension: recall {type: number value_format_name:percent_2}
  dimension: accuracy {type: number value_format_name:percent_2}
  dimension: f1_score {type: number value_format_name:percent_3}
  dimension: log_loss {type: number}
  dimension: roc_auc {type: number}
}

view: roc_curve {
  derived_table: {
    sql: SELECT * FROM ml.ROC_CURVE(
        MODEL ${future_revenue_model.SQL_TABLE_NAME},
        (SELECT * FROM ${testing_input.SQL_TABLE_NAME}));;
  }

  dimension: recall {type: number value_format_name: percent_2}
  dimension: false_positive_rate {type: number}
  dimension: true_positives {type: number }
  dimension: false_positives {type: number}
  dimension: true_negatives {type: number}
  dimension: false_negatives {type: number }
  dimension: precision {
    type:  number
    value_format_name: percent_2
    sql:  ${true_positives} / NULLIF((${true_positives} + ${false_positives}),0);;
  }
  measure: total_false_positives {
    type: sum
    sql: ${false_positives} ;;
  }
  measure: total_true_positives {
    type: sum
    sql: ${true_positives} ;;
  }
}

view: future_revenue_model_training_info {
  derived_table: {
    sql: SELECT  * FROM ml.TRAINING_INFO(MODEL ${future_revenue_model.SQL_TABLE_NAME});;
  }
  dimension: training_run {type: number}
  dimension: iteration {type: number}
  dimension: loss_raw {sql: ${TABLE}.loss;; type: number hidden:yes}
  dimension: eval_loss {type: number}
  dimension: duration_ms {label:"Duration (ms)" type: number}
  dimension: learning_rate {type: number}
  measure: total_iterations {
    type: count
  }
  measure: loss {
    value_format_name: decimal_2
    type: sum
    sql:  ${loss_raw} ;;
  }
  measure: total_training_time {
    type: sum
    label:"Total Training Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
  measure: average_iteration_time {
    type: average
    label:"Average Iteration Time (sec)"
    sql: ${duration_ms}/1000 ;;
    value_format_name: decimal_1
  }
}


########################################## PREDICT FUTURE ############################

view: future_input {
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
      column: revenue_d7 {}
      filters: {
        field: apps.bundle_id
        value: "com.gezellig.roadcrash"
      }
      filters: {
        field: apps.platform
        value: "ios"
      }
      filters: {
        field: reporting_metrics.date_date
        value: "30 days"
      }
    }
  }
}


view: future_revenue_prediction {
  derived_table: {
    sql: SELECT * FROM ml.PREDICT(
          MODEL ${future_revenue_model.SQL_TABLE_NAME},
          (SELECT * FROM ${future_input.SQL_TABLE_NAME}));;
  }
  measure: predicted_revenue_d14{type: sum}
  measure: revenue_d1{type: sum}
  measure: revenue_d2{type: sum}
  measure: revenue_d3{type: sum}
  measure: revenue_d4{type: sum}
  measure: revenue_d5{type: sum}
  measure: revenue_d6{type: sum}
  measure: revenue_d7{type: sum}


  dimension: date {type: date}
  dimension: bundle_id {type: string}
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
