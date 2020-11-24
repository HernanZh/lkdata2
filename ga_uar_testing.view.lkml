view: ga_uar_testing {
  derived_table: {
    sql: select ts_date, uar.bundle_id, uar.platform, revenue from(
             SELECT
                    CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS created_date,
                    user_ad_revenue.advertising_id  AS advertising_id,
                    user_ad_revenue.bundle_id as bundle_id,
                    user_ad_revenue.platform  AS platform,
                    sum(user_ad_revenue.revenue) AS revenue,
                    --user_ad_revenue.ad_network  AS ad_network,
                    --user_ad_revenue.ad_unit  AS ad_unit,
                    --user_ad_revenue.impressions  AS impressions,
                    --SUM(user_ad_revenue.revenue) / COUNT(DISTINCT user_ad_revenue.user_id)  AS arpdau,
                    COUNT(DISTINCT user_ad_revenue.user_id) as distinct_user
                  FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
                  WHERE (((user_ad_revenue.date_created ) >= ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY) AS TIMESTAMP), DAY))))
                  AND (user_ad_revenue.date_created) < ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY) AS TIMESTAMP), DAY))))))
                  -- AND user_ad_revenue.platform='ios'
                  -- AND user_ad_revenue.bundle_id ='com.gezellig.savethedate'
                  AND advertising_id is not null
                  GROUP BY 1,2,3,4
        )uar
        inner join (
                SELECT
                CAST(TIMESTAMP_SECONDS(game_analytics.client_ts)  AS DATE) AS ts_date,
                REPLACE(LOWER(game_analytics.ios_idfa), '-', '') as filtered_uid,
                game_analytics.platform as platform,
                game_analytics.bundle_id as bundle_id
                FROM game_analytics.data_export_new  AS game_analytics
                WHERE (((TIMESTAMP_SECONDS(game_analytics.client_ts) ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
                AND (TIMESTAMP_SECONDS(game_analytics.client_ts) ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
                -- AND game_analytics.bundle_id = 'com.gezellig.savethedate'
                -- AND game_analytics.platform='ios'

        )ga
        on uar.created_date = ga.ts_date
        and uar.advertising_id = ga.filtered_uid
        and uar.bundle_id = ga.bundle_id
        and uar.platform = ga.platform
  --where advertising_id='af09d5a7e5174a96b2b32b1888f2c20c'
  where uar.platform ='ios'
  and uar.bundle_id = 'com.gezellig.savethedate'
  group by 1,2,3,4
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ts_date {
    type: date
    datatype: date
    sql: ${TABLE}.ts_date ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  set: detail {
    fields: [ts_date, bundle_id, platform, revenue]
  }
}
