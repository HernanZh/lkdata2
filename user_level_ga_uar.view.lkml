view: user_level_ga_uar {
  derived_table: {
    sql:
    select * from(
    select
      ad_unit,
      created_date,
      idfa_a.bundle_id,
      idfa_a.build,
      idfa_a.install_campaign,
      idfa_a.days_since_install,
      idfa_a.platform,
      idfa_b.advertising_id as advertising_id,
      idfa_a.country,
      idfa_a.country_bucket,
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
          CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS DATE) AS ts_date,
          --game_analytics.ios_idfa  AS idfa,
          --REPLACE(LOWER(game_analytics.user_id), '-', '') as filtered_uid,
          REPLACE(LOWER(game_analytics.ios_idfa),'-','') as idfa,
          REPLACE(LOWER(game_analytics.ios_idfv),'-','') as idfv,
          game_analytics.platform as platform,
          game_analytics.custom_01  AS AB_custom_01,
          game_analytics.custom_02  AS AB_custom_02,
          game_analytics.custom_03  AS AB_custom_03,
          game_analytics.country_code as country,
          (SELECT
              CASE
          WHEN game_analytics.country_code IN ('AU','CA','DE','NZ','NO','CH', 'GB')  THEN 'T1'
          WHEN game_analytics.country_code IN ('HK','JP','KR','TW')  THEN 'T1_LOC'
          WHEN game_analytics.country_code IN ('AT','BE','DK','FR','NL','SG','SE')  THEN 'T2'
          WHEN game_analytics.country_code IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN')  THEN 'T3'
          WHEN game_analytics.country_code IN ('US')  THEN 'US'
          WHEN game_analytics.country_code IN ('CN')  THEN 'CN'
          ELSE 'Unknown'
          END )AS country_bucket,
          --game_analytics.event_id AS event_id,
            CAST(TIMESTAMP_DIFF((TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS TIMESTAMP), DAY)) , (TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS TIMESTAMP), DAY)) , DAY) AS INT64) AS days_since_install,
          game_analytics.build  AS build,
          game_analytics.install_campaign as install_campaign,
          game_analytics.bundle_id  AS bundle_id,
          --CAST(TIMESTAMP_DIFF((TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS TIMESTAMP), DAY)) , (TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS TIMESTAMP), DAY)) , DAY) AS INT64) AS days_since_install,
          --game_analytics.ip  AS ip,
          AVG(game_analytics.length ) AS avg_session_length,
          (COUNT(DISTINCT game_analytics.session_id )) * (AVG(game_analytics.length )) / (COUNT(DISTINCT game_analytics.user_id ))  AS playtime,
          COUNT(DISTINCT game_analytics.session_id ) AS session_count,
          COUNT(DISTINCT game_analytics.user_id ) AS dau
        FROM game_analytics.data_export_new  AS game_analytics
        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
      )idfa_a
      inner join (
        SELECT
          CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS created_date,
          user_ad_revenue.advertising_id  AS advertising_id,
          user_ad_revenue.platform  AS platform,
          user_ad_revenue.revenue AS revenue,
          user_ad_revenue.ad_unit as ad_unit,
          user_attributes.country as country,
          (SELECT
              CASE
          WHEN user_attributes.country IN ('AU','CA','DE','NZ','NO','CH', 'GB')  THEN 'T1'
          WHEN user_attributes.country IN ('HK','JP','KR','TW')  THEN 'T1_LOC'
          WHEN user_attributes.country IN ('AT','BE','DK','FR','NL','SG','SE')  THEN 'T2'
          WHEN user_attributes.country IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN')  THEN 'T3'
          WHEN user_attributes.country IN ('US')  THEN 'US'
          WHEN user_attributes.country IN ('CN')  THEN 'CN'
          ELSE 'Unknown'
          END) AS country_bucket,
          user_ad_revenue.bundle_id as bundle_id,
          user_ad_revenue.impressions AS impressions,
          SUM(user_ad_revenue.revenue) / COUNT(DISTINCT user_ad_revenue.user_id)  AS arpdau
        FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
        LEFT JOIN tenjin_BigQuery.rs_user_attributes  AS user_attributes ON (COALESCE(user_attributes.advertising_id, user_attributes.developer_device_id)) = user_ad_revenue.advertising_id
        GROUP BY 1,2,3,4,5,6,7,8,9
      )idfa_b
      on idfa_a.idfa = idfa_b.advertising_id
      and idfa_a.ts_date = idfa_b.created_date
      and idfa_a.platform = idfa_b.platform
      and idfa_a.bundle_id = idfa_b.bundle_id
      and idfa_a.country = idfa_b.country
      and idfa_a.country_bucket = idfa_b.country_bucket
      )idfa_table
      Union ALL
      select * from
      (
          select
      ad_unit,
      created_date,
      idfv_a.bundle_id,
      idfv_a.days_since_install,
      idfv_a.build,
      idfv_a.install_campaign,
      idfv_a.platform,
      idfv_b.advertising_id as advertising_id,
      idfv_a.country,
      idfv_a.country_bucket,
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
          CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS DATE) AS ts_date,
          --game_analytics.ios_idfa  AS idfa,
          --REPLACE(LOWER(game_analytics.user_id), '-', '') as filtered_uid,
          REPLACE(LOWER(game_analytics.ios_idfa),'-','') as idfa,
          REPLACE(LOWER(game_analytics.ios_idfv),'-','') as idfv,
          game_analytics.platform as platform,
          game_analytics.custom_01  AS AB_custom_01,
          game_analytics.custom_02  AS AB_custom_02,
          game_analytics.custom_03  AS AB_custom_03,
          game_analytics.country_code as country,
          (SELECT
              CASE
          WHEN game_analytics.country_code IN ('AU','CA','DE','NZ','NO','CH', 'GB')  THEN 'T1'
          WHEN game_analytics.country_code IN ('HK','JP','KR','TW')  THEN 'T1_LOC'
          WHEN game_analytics.country_code IN ('AT','BE','DK','FR','NL','SG','SE')  THEN 'T2'
          WHEN game_analytics.country_code IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN')  THEN 'T3'
          WHEN game_analytics.country_code IN ('US')  THEN 'US'
          WHEN game_analytics.country_code IN ('CN')  THEN 'CN'
          ELSE 'Unknown'
          END) AS country_bucket,
          --game_analytics.country_bucket as country_bucket,
          --game_analytics.event_id AS event_id,
          CAST(TIMESTAMP_DIFF((TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS TIMESTAMP), DAY)) , (TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS TIMESTAMP), DAY)) , DAY) AS INT64) AS days_since_install,
          game_analytics.build  AS build,
          game_analytics.install_campaign as install_campaign,
          game_analytics.bundle_id  AS bundle_id,
          --CAST(TIMESTAMP_DIFF((TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS TIMESTAMP), DAY)) , (TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS TIMESTAMP), DAY)) , DAY) AS INT64) AS days_since_install,
          --game_analytics.ip  AS ip,
          AVG(game_analytics.length ) AS avg_session_length,
          (COUNT(DISTINCT game_analytics.session_id )) * (AVG(game_analytics.length )) / (COUNT(DISTINCT game_analytics.user_id ))  AS playtime,
          COUNT(DISTINCT game_analytics.session_id ) AS session_count,
          COUNT(DISTINCT game_analytics.user_id ) AS dau
        FROM game_analytics.data_export_new  AS game_analytics
        GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
      )idfv_a
      inner join (
        SELECT
          CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS created_date,
          user_ad_revenue.advertising_id  AS advertising_id,
          user_ad_revenue.platform  AS platform,
          user_ad_revenue.revenue AS revenue,
          user_ad_revenue.ad_unit as ad_unit,
          user_attributes.country as country,
          (SELECT
              CASE
          WHEN user_attributes.country IN ('AU','CA','DE','NZ','NO','CH', 'GB')  THEN 'T1'
          WHEN user_attributes.country IN ('HK','JP','KR','TW')  THEN 'T1_LOC'
          WHEN user_attributes.country IN ('AT','BE','DK','FR','NL','SG','SE')  THEN 'T2'
          WHEN user_attributes.country IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN')  THEN 'T3'
          WHEN user_attributes.country IN ('US')  THEN 'US'
          WHEN user_attributes.country IN ('CN')  THEN 'CN'
          ELSE 'Unknown'
          END) AS country_bucket,
          user_ad_revenue.bundle_id as bundle_id,
          user_ad_revenue.impressions AS impressions,
          SUM(user_ad_revenue.revenue) / COUNT(DISTINCT user_ad_revenue.user_id)  AS arpdau
        FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
        LEFT JOIN tenjin_BigQuery.rs_user_attributes  AS user_attributes ON (COALESCE(user_attributes.advertising_id, user_attributes.developer_device_id)) = user_ad_revenue.advertising_id
        GROUP BY 1,2,3,4,5,6,7,8,9
      )idfv_b
      on idfv_a.idfv = idfv_b.advertising_id
      and idfv_a.ts_date = idfv_b.created_date
      and idfv_a.platform = idfv_b.platform
      and idfv_a.bundle_id = idfv_b.bundle_id
      and idfv_a.country = idfv_b.country
      and idfv_a.country_bucket = idfv_b.country_bucket
      )idfv_table
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
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

  dimension: install_campaign {
    type: string
    sql: ${TABLE}.install_campaign ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: country_bucket {
    type: string
    sql: ${TABLE}.country_bucket ;;
  }

  dimension: days_since_install {
    type: string
    sql: ${TABLE}.days_since_install ;;
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

  dimension: revenue_bucket{
    case: {
      when: {
        sql: ${TABLE}.revenue <= 0.2;;
        label: "< $0.2"
      }
      when: {
        sql: ${TABLE}.revenue> 0.2 AND ${TABLE}.revenue <= 0.5;;
        label: "Between $0.2 and $0.5"
      }
      when: {
        sql: ${TABLE}.revenue > 0.5 AND ${TABLE}.revenue <= 1;;
        label: "Between $0.5 and $1.0"
      }
      when: {
        sql: ${TABLE}.revenue > 1;;
        label: "> $1.0"
      }
      else:"Unknown"
    }
  }

  measure: playtime {
    type: number
    sql: ${session_count} * ${avg_session_length} / ${dau} ;;
  }

  #${session_count} * ${avg_session_length} / ${DAU}

  measure: avg_session_length {
    type: number
    sql: sum(${TABLE}.avg_session_length) ;;
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
    type: count_distinct
    sql: ${TABLE}.advertising_id ;;
  }

  measure: impressions {
    type: number
    sql:sum(${TABLE}.impressions) ;;
  }

  set: detail {
    fields: [
      created_date,
      bundle_id,
      country,
      platform,
      playtime,
      avg_session_length,
      session_count,
      revenue
    ]
  }
}
