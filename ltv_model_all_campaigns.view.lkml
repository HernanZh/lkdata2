view: ltv_model_all_campaigns {
  derived_table: {
    persist_for: "10 minutes"
    # datagroup_trigger: tenjin_test2_model_datagroup
    sql: select a.campaign_name, a.ad_networks_name, ln(a.xday) as xday,ln(a.daily_user/b.daily_user) as Retention from
    ( SELECT cast(campaigns.name as STRING) as campaign_name,
    cast(ad_networks.name as STRING)  AS ad_networks_name,
        CAST(cohort_behavior.xday AS INT64)  AS xday,
        CAST(SUM(cohort_behavior.users ) AS INT64) AS daily_user
      FROM tenjin_BigQuery.cohort_behavior  AS cohort_behavior
      LEFT JOIN tenjin_BigQuery.campaigns  AS campaigns ON cohort_behavior.campaign_id = campaigns.id
      LEFT JOIN tenjin_BigQuery.apps  AS apps ON campaigns.app_id = apps.id
      LEFT JOIN tenjin_BigQuery.ad_networks  AS ad_networks ON campaigns.ad_network_id = ad_networks.id

      WHERE ((((cohort_behavior.date ) >= (CAST('2018-01-01' AS DATE)) AND
      (cohort_behavior.date ) < (CAST('2018-12-31' AS DATE))))) and
      (apps.bundle_id = 'com.luckykat.kaijurush') AND (apps.platform = 'ios')
      and cohort_behavior.xday>0
      GROUP BY 1,2,3
      ORDER BY 1,2,3) as a inner join ( SELECT cast(campaigns.name as STRING) as campaign_name,
      cast(ad_networks.name as STRING)  AS ad_networks_name,

        CAST(SUM(cohort_behavior.users ) AS INT64) AS daily_user
      FROM tenjin_BigQuery.cohort_behavior  AS cohort_behavior
      LEFT JOIN tenjin_BigQuery.campaigns  AS campaigns ON cohort_behavior.campaign_id = campaigns.id
      LEFT JOIN tenjin_BigQuery.apps  AS apps ON campaigns.app_id = apps.id
      LEFT JOIN tenjin_BigQuery.ad_networks  AS ad_networks ON campaigns.ad_network_id = ad_networks.id

      WHERE ((((cohort_behavior.date ) >= (CAST('2018-01-01' AS DATE)) AND
      (cohort_behavior.date ) < (CAST('2018-12-31' AS DATE))))) and
      (apps.bundle_id = 'com.luckykat.kaijurush') AND (apps.platform = 'ios')
      and cohort_behavior.xday=0
      GROUP BY 1,2
      ORDER BY 1,2
      ) as b on a.campaign_id=b.campaign_id where a.daily_user>0
          ;;
  }

  dimension: campaign_name {type: string}
  dimension: ad_networks_name {type: string}

  dimension: xday {type: number}
  dimension: xday_final {type: number
    sql: round(exp(${xday}),0);;
    }
  dimension: Retention {type:number}
  measure:  Ret {type:sum
    sql:${Retention};;}
  dimension: Retention_final {type: number
    sql: exp(${Retention});;
  }

}
explore: ltv_model_all_campaigns {}

view: ltv_reg {
  derived_table: {
    persist_for: "24 hours"
    #datagroup_trigger: tenjin_test2_model_datagroup
    sql_create:
      CREATE OR REPLACE MODEL
        ${SQL_TABLE_NAME}
      OPTIONS
          ( model_type='linear_reg',
            labels=['Retention'],
            min_rel_progress = 0.00001,
            max_iteration = 50 )
      AS
      SELECT
        *
      FROM
        ${ltv_model_all_campaigns.SQL_TABLE_NAME}
    ;;
  }
}



explore: ltv_eval {}
explore: ltv_reg {}

view: ltv_eval {
  derived_table: {
    sql:
      Select
      *
      FROM
      ML.EVALUATE(MODEL ${ltv_reg.SQL_TABLE_NAME}),
      (SELECT
        *
      FROM
        ${ltv_model_all_campaigns.SQL_TABLE_NAME});;
  }
  dimension: mean_absolute_error {type: number}
  dimension: mean_squared_error {type: number}
  dimension: mean_squared_log_error {type: number}
  dimension: median_absolute_error {type: number}
  dimension: r2_score {type: number}
  dimension: explained_variance {type: number}
}

view: ltv_train {
  derived_table: {
    sql:
      Select
      *
      FROM
      ML.TRAINING_INFO(MODEL ${ltv_reg.SQL_TABLE_NAME}),
      (SELECT
        *
      FROM
        ${ltv_model_all_campaigns.SQL_TABLE_NAME});;
  }
  dimension: training_run {type: number}
  dimension: iteration {type: number}
  dimension: loss {type: number}
  dimension: eval_loss {type: number}
  dimension: duration_ms {label:"Duration (ms)" type: number}
  dimension: learning_rate{type: number}
  measure: iterations {type: count}
  measure: total_loss {type: sum sql:${loss} ;;}
}

explore: ltv_train {}
explore: ltv_pred {
  join: ltv_model_all_campaigns {
    type: left_outer
    sql_on: ${ltv_pred.campaign_name} = ${ltv_model_all_campaigns.campaign_name} and
    ${ltv_pred.xday_final} = ${ltv_model_all_campaigns.xday_final};;
    relationship: many_to_one
  }
}

view: ltv_pred_all_campaigns {
  derived_table: {
    persist_for: "10 minutes"
    # datagroup_trigger: tenjin_test2_model_datagroup
    sql: SELECT
       b.campaign_name, b.ad_networks_name, ln(a.xday) as xday

      FROM  (select CAST(cohort_behavior.xday AS INT64)  AS xday from tenjin_BigQuery.cohort_behavior  AS cohort_behavior
      LEFT JOIN tenjin_BigQuery.campaigns  AS campaigns ON cohort_behavior.campaign_id = campaigns.id
      LEFT JOIN tenjin_BigQuery.apps  AS apps ON campaigns.app_id = apps.id
      where cohort_behavior.xday>0 and xday<=365
      GROUP BY 1
      ORDER BY 1) as a cross join
      (select cast(campaigns.name as STRING) as campaign_name,
      cast(ad_networks.name as STRING)  AS ad_networks_name
      from tenjin_BigQuery.cohort_behavior  AS cohort_behavior
      LEFT JOIN tenjin_BigQuery.campaigns  AS campaigns ON cohort_behavior.campaign_id = campaigns.id
      LEFT JOIN tenjin_BigQuery.apps  AS apps ON campaigns.app_id = apps.id
      LEFT JOIN tenjin_BigQuery.ad_networks  AS ad_networks ON campaigns.ad_network_id = ad_networks.id

      WHERE ((((cohort_behavior.date ) >= (CAST('2018-01-01' AS DATE)) AND
      (cohort_behavior.date ) < (CAST('2018-12-31' AS DATE))))) and (apps.bundle_id = 'com.luckykat.kaijurush') AND (apps.platform = 'ios')
      GROUP BY 1,2
      ORDER BY 1,2
      ) as b
          ;;
  }

  dimension: campaign_name {type: string}
  dimension: ad_networks_name {type: string}

  dimension: xday {type: number}
#   measure: daily_user {type:sum
#     sql: ${TABLE}.daily_user ;;
#   }

}
explore: ltv_pred_all_campaigns {}

view: ltv_pred {
  derived_table: {
    sql:
      Select
      *
      FROM
      ML.PREDICT(MODEL ${ltv_reg.SQL_TABLE_NAME},
      (SELECT
        *
      FROM
        ${ltv_pred_all_campaigns.SQL_TABLE_NAME}));;
  }
  dimension: campaign_name {type: string}
  dimension: ad_networks_name {type: string}
  measure: Channel_count {type: count_distinct
    sql: ${ad_networks_name};;}
  dimension: xday {type: number}
  dimension: xday_final {type: number
    sql:round(exp(${xday}),0);;}

  dimension: predicted_Retention {type: number}
  dimension: predicted_Ret_final {type:number
    sql: exp(${predicted_Retention});; }

}
