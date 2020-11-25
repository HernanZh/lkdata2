view: user_level_ga_uar {
  derived_table: {
    sql: select
      filtered_uid,
      created_date,
      a.bundle_id,
     -- days_since_install,
      a.platform,
     -- country,
     -- country_bucket,
      --AB_custom_01,
      --AB_custom_02,
      --AB_custom_03,
      playtime,
      avg_session_length,
      session_count,
      revenue,
      --impressions,
      arpdau,
      dau
      from(
        SELECT
          CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS DATE) AS ts_date,
          --game_analytics.ios_idfa  AS idfa,
          REPLACE(LOWER(game_analytics.user_id), '-', '') as filtered_uid,
          game_analytics.platform as platform,
          --game_analytics.custom_01  AS AB_custom_01,
          --game_analytics.custom_02  AS AB_custom_02,
          --game_analytics.custom_03  AS AB_custom_03,
          --game_analytics.event_id AS event_id,
          --game_analytics.build  AS build,
          game_analytics.bundle_id  AS bundle_id,
          --CAST(TIMESTAMP_DIFF((TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS TIMESTAMP), DAY)) , (TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS TIMESTAMP), DAY)) , DAY) AS INT64) AS days_since_install,
          --game_analytics.ip  AS ip,
          AVG(game_analytics.length ) AS avg_session_length,
          (COUNT(DISTINCT game_analytics.session_id )) * (AVG(game_analytics.length )) / (COUNT(DISTINCT game_analytics.user_id ))  AS playtime,
          COUNT(DISTINCT game_analytics.session_id ) AS session_count,
          COUNT(DISTINCT game_analytics.user_id ) AS dau
        FROM game_analytics.data_export_new  AS game_analytics
        GROUP BY 1,2,3,4
      )a
      inner join (
      SELECT
        CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS created_date,
        user_ad_revenue.advertising_id  AS advertising_id,
        user_ad_revenue.platform  AS platform,
        user_ad_revenue.revenue AS revenue,
        user_ad_revenue.bundle_id as bundle_id,
        SUM(user_ad_revenue.revenue) / COUNT(DISTINCT user_ad_revenue.user_id)  AS arpdau
      FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
      GROUP BY 1,2,3,4,5
      )b
      on a.filtered_uid = b.advertising_id
      and a.ts_date = b.created_date
      and a.platform = b.platform
      and a.bundle_id = b.bundle_id

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

  # dimension: event_id {
  #   type: string
  #   sql: ${TABLE}.event_id ;;
  # }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
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
    type: number
    sql: mean(${TABLE}.playtime) ;;
  }

  measure: avg_session_length {
    type: number
    sql: mean(${TABLE}.avg_session_length) ;;
  }

  measure: session_count {
    type: number
    sql: sum(${TABLE}.session_count) ;;
  }

  measure: revenue {
    type: number
    sql: sum(${TABLE}.revenue) ;;
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
      platform,
      playtime,
      avg_session_length,
      session_count,
      revenue
    ]
  }
}
