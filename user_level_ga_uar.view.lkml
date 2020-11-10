view: user_level_ga_uar {
  derived_table: {
    sql: select
      filtered_uid,
      created_date,
      bundle_id,
      days_since_install,
      build,
      event_id,
      platform,
      country,
      country_bucket,
      ip,
      ad_network,
      ad_unit,
      AB_custom_01,
      AB_custom_02,
      AB_custom_03,
      playtime,
      avg_session_length,
      session_count,
      revenue,
      impressions,
      arpdau,
      dau
      from(
        SELECT
          game_analytics.ios_idfa  AS idfa,
          REPLACE(LOWER(game_analytics.user_id), '-', '') as filtered_uid,
          game_analytics.custom_01  AS AB_custom_01,
          game_analytics.custom_02  AS AB_custom_02,
          game_analytics.custom_03  AS AB_custom_03,
          game_analytics.event_id AS event_id,
          game_analytics.build  AS build,
          (SELECT
            CASE
          WHEN game_analytics.country_code IN ('AU','CA','DE','NZ','NO','CH', 'GB')  THEN '0'
          WHEN game_analytics.country_code IN ('HK','JP','KR','TW')  THEN '1'
          WHEN game_analytics.country_code IN ('AT','BE','DK','FR','NL','SG','SE')  THEN '2'
          WHEN game_analytics.country_code IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN')  THEN '3'
          WHEN game_analytics.country_code IN ('US')  THEN '4'
          WHEN game_analytics.country_code IN ('CN')  THEN '5'
          ELSE '6'
          END AS game_analytics_country_bucket__sort_,
            CASE
          WHEN game_analytics.country_code IN ('AU','CA','DE','NZ','NO','CH', 'GB')  THEN 'T1'
          WHEN game_analytics.country_code IN ('HK','JP','KR','TW')  THEN 'T1_LOC'
          WHEN game_analytics.country_code IN ('AT','BE','DK','FR','NL','SG','SE')  THEN 'T2'
          WHEN game_analytics.country_code IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN')  THEN 'T3'
          WHEN game_analytics.country_code IN ('US')  THEN 'US'
          WHEN game_analytics.country_code IN ('CN')  THEN 'CN'
          ELSE 'Unknown')
          END AS country_bucket,
          game_analytics.bundle_id  AS bundle_id,
          CAST(TIMESTAMP_DIFF((TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS TIMESTAMP), DAY)) , (TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS TIMESTAMP), DAY)) , DAY) AS INT64) AS days_since_install,
          game_analytics.ip  AS ip,
          AVG(game_analytics.length ) AS avg_session_length,
          (COUNT(DISTINCT game_analytics.session_id )) * (AVG(game_analytics.length )) / (COUNT(DISTINCT game_analytics.user_id ))  AS playtime,
          COUNT(DISTINCT game_analytics.session_id ) AS session_count,
          COUNT(DISTINCT game_analytics.user_id ) AS dau
        FROM game_analytics.data_export_new  AS game_analytics

        WHERE (((TIMESTAMP_SECONDS(game_analytics.arrival_ts) ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY))) AND (TIMESTAMP_SECONDS(game_analytics.arrival_ts) ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY), INTERVAL 30 DAY)))))
        GROUP BY 1,2,3,4,5,6,7,8,9,10,11
        ORDER BY 2 DESC
      )a
      inner join (
      SELECT
        CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS created_date,
        user_attributes.country  AS country,
        user_ad_revenue.advertising_id  AS advertising_id,
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
      GROUP BY 1,2,3,4,5,6,7
      ORDER BY 7 DESC,6
      )b
      on a.filtered_uid = b.advertising_id

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: filtered_uid {
    type: string
    sql: ${TABLE}.filtered_uid ;;
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

  dimension: build {
    type: string
    sql: ${TABLE}.build ;;
  }

  dimension: days_since_install {
    type:  number
    sql:  ${TABLE}.days_since_install;;
  }

  dimension: event_id {
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: country_bucket {
    type:  string
    sql: ${TABLE}.country_bucket ;;
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

  dimension: ab_custom_01 {
    type: string
    sql: ${TABLE}.AB_custom_01 ;;
  }

  dimension: ab_custom_02 {
    type: string
    sql: ${TABLE}.AB_custom_02 ;;
  }

  dimension: ab_custom_03 {
    type: string
    sql: ${TABLE}.AB_custom_03 ;;
  }

  measure: playtime {
    type: average
    sql: ${TABLE}.playtime ;;
  }

  measure: avg_session_length {
    type: sum
    sql: ${TABLE}.avg_session_length ;;
  }

  measure: session_count {
    type: sum
    sql: ${TABLE}.session_count ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: avg_arpdau {
    type: average
    sql: ${TABLE}.arpdau ;;
  }

  measure: avg_impressions {
    type: average
    sql: ${TABLE}.impressions ;;
  }

  measure: dau {
    type: sum
    sql: ${TABLE}.dau ;;
  }

  set: detail {
    fields: [
      filtered_uid,
      created_date,
      bundle_id,
      build,
      platform,
      country,
      country_bucket,
      ip,
      ad_network,
      ad_unit,
      ab_custom_01,
      ab_custom_02,
      ab_custom_03,
      playtime,
      avg_session_length,
      session_count,
      revenue,
      avg_impressions,
      avg_arpdau
    ]
  }
}
