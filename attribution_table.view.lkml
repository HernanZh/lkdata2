view: attribution_table {
  derived_table: {
    sql: select
      raw_idfv,
      created_date,
      bundle_id,
      device,
      build,
      os_version,
      platform,
      country,
      ip,
      ad_network,
      ad_unit,
      playtime,
      avg_session_length,
      session_count,
      revenue,
      impressions
      from(
        SELECT
          game_analytics.ios_idfv  AS idfv,
          REPLACE(LOWER(game_analytics.ios_idfv), '-', '') as raw_idfv,
          game_analytics.os_version as os_version,
          game_analytics.build  AS build,
          game_analytics.country_code as country,
          game_analytics.device as device,
          game_analytics.bundle_id  AS bundle_id,
          game_analytics.ip  AS ip,
          AVG(game_analytics.length ) AS avg_session_length,
          (COUNT(DISTINCT game_analytics.session_id )) * (AVG(game_analytics.length )) / (COUNT(DISTINCT game_analytics.user_id ))  AS playtime,
          COUNT(DISTINCT game_analytics.session_id ) AS session_count
        FROM game_analytics.data_export_new  AS game_analytics

        WHERE (((TIMESTAMP_SECONDS(game_analytics.arrival_ts) ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY))) AND (TIMESTAMP_SECONDS(game_analytics.arrival_ts) ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY), INTERVAL 30 DAY)))))
        GROUP BY 1,2,3,4,5,6,7,8
        ORDER BY 2 DESC
      )a
      inner join (
      SELECT
        CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS created_date,
        user_ad_revenue.idfv  AS idfv,
        user_ad_revenue.impressions  AS impressions,
        user_ad_revenue.ad_network  AS ad_network,
        user_ad_revenue.platform  AS platform,
        user_ad_revenue.ad_unit  AS ad_unit,
        SUM(user_ad_revenue.revenue) / COUNT(DISTINCT user_ad_revenue.user_id)  AS arpdau,
        COALESCE(SUM(user_ad_revenue.revenue ), 0) AS revenue
      FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
      LEFT JOIN tenjin_BigQuery.rs_user_attributes  AS user_attributes ON (COALESCE(user_attributes.advertising_id, user_attributes.developer_device_id)) = user_ad_revenue.advertising_id
      LEFT JOIN tenjin_BigQuery.campaigns  AS campaigns ON user_attributes.campaign_id = campaigns.id
      LEFT JOIN tenjin_BigQuery.apps  AS apps ON campaigns.app_id = apps.id

      WHERE (((user_ad_revenue.date_created ) >= ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY) AS TIMESTAMP), DAY)))) AND (user_ad_revenue.date_created ) < ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY), INTERVAL 30 DAY) AS TIMESTAMP), DAY))))))
      GROUP BY 1,2,3,4,5,6
      ORDER BY 7 DESC,6
      )b
      on a.raw_idfv = b.idfv
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

-- SELECT
--   CAST(CAST(user_level_ga_uar.created_date  AS TIMESTAMP) AS DATE) AS user_level_ga_uar_created_date,
--   user_level_ga_uar.filtered_uid  AS user_level_ga_uar_filtered_uid,
--   user_level_ga_uar.build  AS user_level_ga_uar_build,
--   user_level_ga_uar.bundle_id  AS user_level_ga_uar_bundle_id,
--   user_level_ga_uar.country  AS user_level_ga_uar_country,
--   user_level_ga_uar.ip  AS user_level_ga_uar_ip,
--   user_level_ga_uar.platform  AS user_level_ga_uar_platform,
--   user_level_ga_uar.ad_network  AS user_level_ga_uar_ad_network,
--   user_level_ga_uar.ad_unit  AS user_level_ga_uar_ad_unit,
--   user_level_ga_uar.revenue  AS user_level_ga_uar_revenue,
--   user_level_ga_uar.event_id  AS user_level_ga_uar_event_id,
--   COALESCE(SUM(user_level_ga_uar.avg_session_length ), 0) AS user_level_ga_uar_avg_session_length,
--   AVG(user_level_ga_uar.impressions ) AS user_level_ga_uar_impressions,
--   AVG(user_level_ga_uar.playtime ) AS user_level_ga_uar_playtime,
--   COALESCE(SUM(user_level_ga_uar.session_count ), 0) AS user_level_ga_uar_session_count
-- FROM user_level_ga_uar

-- WHERE (((user_level_ga_uar.created_date ) >= ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY) AS TIMESTAMP), DAY)))) AND (user_level_ga_uar.created_date ) < ((DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY) AS TIMESTAMP), DAY)))))) AND (user_level_ga_uar.bundle_id = 'com.gezellig.savethedate') AND (user_level_ga_uar.platform = 'ios')
-- GROUP BY 1,2,3,4,5,6,7,8
-- ORDER BY 2 DESC
-- LIMIT 500
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: raw_idfv {
    type: string
    sql: ${TABLE}.raw_idfv ;;
  }

  dimension: created_date {
    type: date
    datatype: date
    sql: ${TABLE}.created_date ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: build {
    type: string
    sql: ${TABLE}.build ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: ad_network {
    type: string
    sql: ${TABLE}.ad_network ;;
  }

  dimension: ad_unit {
    type: string
    sql: ${TABLE}.ad_unit ;;
  }

  dimension: playtime {
    type: number
    sql: ${TABLE}.playtime ;;
  }

  dimension: avg_session_length {
    type: number
    sql: ${TABLE}.avg_session_length ;;
  }

  dimension: session_count {
    type: number
    sql: ${TABLE}.session_count ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  set: detail {
    fields: [
      raw_idfv,
      created_date,
      bundle_id,
      device,
      build,
      os_version,
      platform,
      country,
      ip,
      ad_network,
      ad_unit,
      playtime,
      avg_session_length,
      session_count,
      revenue,
      impressions
    ]
  }
}
