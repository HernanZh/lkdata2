view: ga_ilrd {
  derived_table: {
    sql: select
      ga_minimalistic.*,
      impressions.ad_network,
      impressions.ad_unit_name,
      impressions.ad_unit,
      impressions.placement,
      impressions.precision,
      impressions.publisher_revenue,
      impressions.revenue,
      impressions.impressions
      from
      (
        (select
              game_info.bundle_id,
              ga_base.*,
              (session_count * avg_session_length)/DAU as playtime
              From(
                  SELECT
                  arrival_date,
                  user_meta_install_ts,
                  arrival_ts,
                  game_id,
                  UPPER(user_id) as user_id,
                  country_code as country,
                  user_meta_install_campaign as install_campaign,
                  limited_ad_tracking as LAT,
                  platform,
                  custom_01,
                  custom_02,
                  custom_03,
                  COUNT(DISTINCT user_id) as DAU,
                  COUNT(DISTINCT session_id) as session_count,
                  AVG(length) as avg_session_length

                  from gameanalytics.GA_session_end as ga
                  group by 1,2,3,4,5,6,7,8,9,10,11,12
                  ) ga_base

              --Join in games table to get the bundle_id
              join (select
                    id,
                    bundle_id,
                    CASE
                      WHEN store_platform = 'apple_ios' then 'ios'
                      WHEN store_platform = 'google_play' then 'android'
                      WHEN store_platform = 'other' then 'web'
                      ELSE NULL
                    END AS platform
                    from gameanalytics.games) game_info
              on game_info.id = ga_base.game_id
              and game_info.platform = ga_base.platform
        ) ga_minimalistic

        inner join (
                select
                  DATE(arrival_date) as arrival_date, --REPLACE THIS WITH ARRIVAL_DATE ONCE IMPLEMENTED
                  UPPER(user_id) as user_id,
                  game_id,
                  adNetwork as ad_network,
                  adunit_name as ad_unit_name,
                  adUnit as ad_unit,
                  placement,
                  precision,
                  country,
                  publisher_revenue,
                  revenue,
                  count(ad_unit) as impressions,
                from gameanalytics.impressions AS impressions
                group by 1,2,3,4,5,6,7,8,9,10,11
                )impressions
          on impressions.user_id = ga_minimalistic.user_id
          and impressions.arrival_date = ga_minimalistic.arrival_date
          and impressions.game_id = ga_minimalistic.game_id
          and impressions.country = ga_minimalistic.country
      )
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: arrival_date {
    type: date
    datatype: date
    sql: ${TABLE}.arrival_date ;;
  }

  dimension_group: since_install {
    type: duration
    intervals: [day]
    sql_start: ${install_ts_date::datetime} ;;
    sql_end: ${arrival_ts_date::datetime} ;;
  }

  dimension_group: arrival_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: TIMESTAMP_SECONDS(${TABLE}.arrival_ts) ;;
  }

  dimension_group: install_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    # sql: TIMESTAMP_SECONDS(${TABLE}.install_ts) ;;
    sql: TIMESTAMP_SECONDS(${TABLE}.user_meta_install_ts) ;;
  }


  dimension: game_id {
    type: number
    sql: ${TABLE}.game_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: ios_idfa {
    type: string
    sql: ${TABLE}.ios_idfa ;;
  }

  dimension: ios_idfv {
    type: string
    sql: ${TABLE}.ios_idfv ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: country_bucket {
    type: string
    case: {
      when: {
        sql: ${TABLE}.country IN ('AU','CA','DE','NZ','NO','CH', 'GB') ;;
        label: "T1"
      }
      when: {
        sql: ${TABLE}.country IN ('HK','JP','KR','TW') ;;
        label: "T1_LOC"
      }
      when: {
        sql: ${TABLE}.country IN ('AT','BE','DK','FR','NL','SG','SE') ;;
        label: "T2"
      }
      when: {
        sql: ${TABLE}.country IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN') ;;
        label: "T3"
      }
      when: {
        sql: ${TABLE}.country IN ('US') ;;
        label: "US"
      }
      when: {
        sql: ${TABLE}.country IN ('CN') ;;
        label: "CN"
      }
      else: "Unknown"
    }
  }

  dimension: install_campaign {
    type: string
    sql: ${TABLE}.install_campaign ;;
  }

  dimension: lat {
    type: string
    sql: ${TABLE}.LAT ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: custom_01 {
    type: string
    sql: ${TABLE}.custom_01 ;;
  }

  dimension: custom_02 {
    type: string
    sql: ${TABLE}.custom_02 ;;
  }

  dimension: custom_03 {
    type: string
    sql: ${TABLE}.custom_03 ;;
  }

  measure: dau {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }

  measure: session_count {
    type: sum
    sql: ${TABLE}.session_count ;;
  }

  measure: avg_session_count {
    type: average
    sql: ${TABLE}.session_count ;;
    value_format: "#.#"
  }

  measure: avg_session_length {
    type: average
    sql: ${TABLE}.avg_session_length ;;
    value_format: "#.#"
  }

  measure: playtime {
    type: sum
    sql: ${TABLE}.playtime ;;
    value_format: "#.#"
  }

  measure: avg_playtime {
    type: average
    sql: ${TABLE}.playtime ;;
    value_format: "#.#"
  }

  dimension: ad_network {
    type: string
    sql: ${TABLE}.ad_network ;;
  }

  dimension: ad_unit_name {
    type: string
    sql: ${TABLE}.ad_unit_name ;;
  }

  dimension: ad_unit {
    type: string
    sql: ${TABLE}.ad_unit ;;
  }

  dimension: placement {
    type: string
    sql: ${TABLE}.placement ;;
  }

  dimension: precision {
    type: string
    sql: ${TABLE}.precision ;;
  }

  measure: publisher_revenue {
    type: sum
    sql: ${TABLE}.publisher_revenue ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: impressions {
    type: number
    sql: count(${TABLE}.ad_unit) ;;
  }

  set: detail {
    fields: [
      bundle_id,
      arrival_date,
      game_id,
      user_id,
      ios_idfa,
      ios_idfv,
      country,
      install_campaign,
      lat,
      platform,
      custom_01,
      custom_02,
      custom_03,
      dau,
      session_count,
      avg_session_length,
      playtime,
      ad_network,
      ad_unit_name,
      ad_unit,
      placement,
      precision,
      publisher_revenue,
      revenue,
      impressions
    ]
  }
}
