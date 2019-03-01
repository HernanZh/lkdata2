view: ltv_model{
  derived_table: {
    persist_for: "10 minutes"
    distribution_style: all
    # datagroup_trigger: tenjin_test2_model_datagroup
    sql: SELECT
        CAST(cohort_behavior.xday AS INT64)  AS xday,
        CAST(COALESCE(SUM(cohort_behavior.users ), 0) AS INT64) AS daily_user
      FROM tenjin_BigQuery.cohort_behavior  AS cohort_behavior
      LEFT JOIN tenjin_BigQuery.campaigns  AS campaigns ON cohort_behavior.campaign_id = campaigns.id
      LEFT JOIN tenjin_BigQuery.apps  AS apps ON campaigns.app_id = apps.id

      WHERE ((((cohort_behavior.date ) >= (CAST('2018-01-01' AS DATE)) AND
      (cohort_behavior.date ) < (CAST('2018-12-31' AS DATE)))))
      AND (apps.bundle_id = 'com.luckykat.kaijurush') AND (apps.platform = 'ios')
      and (campaigns.id = '020e57e8-960f-4354-a628-51b9a8f5ac72')
      GROUP BY 1
      ORDER BY 1
          ;;
  }
}

#campaigns.id  AS "campaigns.id",


view: ltv_training {
  derived_table: {
    persist_for: "24 hours"
    #datagroup_trigger: tenjin_test2_model_datagroup
    sql_create:
      CREATE OR REPLACE MODEL
        ${SQL_TABLE_NAME}
      OPTIONS
          ( model_type='linear_reg',
            labels=['daily_user'],
            max_iteration=50 )
      AS
      SELECT
        *
      FROM
        ${ltv_model.SQL_TABLE_NAME}
    ;;
  }
}



explore: ltv_evaluation {}
explore: ltv_training {}

view: ltv_evaluation {
  derived_table: {
    sql:
      Select
      *
      FROM
      ML.EVALUATE( MODEL ${ltv_training.SQL_TABLE_NAME}),
      (SELECT
        *
      FROM
        ${ltv_model.SQL_TABLE_NAME});;
  }
  dimension: mean_absolute_error {type: number}
  dimension: mean_squared_error {type: number}
  dimension: mean_squared_log_error {type: number}
  dimension: median_absolute_error {type: number}
  dimension: r2_score {type: number}
  dimension: explained_variance {type: number}
}
