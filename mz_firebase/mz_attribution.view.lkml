view: mz_attribution {
  derived_table: {
    sql: -- SELECT date,ROUND(SUM(banner_revenue)+SUM(interstitial_revenue)+SUM(rewarded_revenue),2) as sum_revenue
      -- FROM(
      SELECT  suffix as date,
              user_first_touch_timestamp,
              network_name,
              campaign_name,
              creative_name,
              firebase_platform,
              country,
              firebase_id,
              user_pseudo_id,
              banner_revenue,
              interstitial_revenue,
              rewarded_revenue,
              engagement_time
              FROM(
        SELECT
        suffix,
        events.device.advertising_id as firebase_id,
        platform as firebase_platform,
        user_pseudo_id,
        -- userProperty.value.string_value as AB_group,
        -- userProperty.key as experiment,
        geo.country as country,
        events.user_first_touch_timestamp as user_first_touch_timestamp,
        --DATE_DIFF(TIMESTAMP(PARSE_DATE('%Y%m%d',suffix)),TIMESTAMP_MICROS(events.user_first_touch_timestamp) ,DAY) as cohort_day,
        SUM((SELECT value.int_value FROM UNNEST(event_params) WHERE key = "engagement_time_msec" AND value.int_value>0)) as engagement_time,
        COALESCE(SUM(( (select value.double_value from UNNEST(events.event_params) where value.double_value IS NOT NULL AND (suffix between '20210820' AND '20210914')AND event_name='ad_revenue_banner')  ) ), 0) AS banner_revenue,
        COALESCE(SUM(( (select value.double_value from UNNEST(events.event_params) where value.double_value IS NOT NULL AND (suffix between '20210820' AND '20210914')AND event_name='ad_revenue_interstitial')  ) ), 0) AS interstitial_revenue,
        COALESCE(SUM(( (select value.double_value from UNNEST(events.event_params) where value.double_value IS NOT NULL AND (suffix between '20210820' AND '20210914')AND event_name='ad_revenue_rewarded')  ) ), 0) AS rewarded_revenue,
        COALESCE(SUM(( (select value.double_value from UNNEST(events.event_params) where value.double_value IS NOT NULL AND (suffix between '20210820' AND '20210914'))  ) ), 0) AS events_sum_revenue,
        FROM `lk-datawarehouse-2.mz_firebase.mz_events` events
        -- UNNEST(user_properties) as userProperty
        WHERE (suffix BETWEEN '20210820' and '20210914')
        -- AND events.platform = "ANDROID"
        --AND event_name in("user_engagement","ad_revenue_banner","ad_revenue_interstitial","ad_revenue_rewarded")
        group by 1,2,3,4,5,6)firebase

      left join (
      SELECT * from(
      SELECT
        advertising_id as tenjin_id,
        source_campaign_id,
        creative_name,
        platform
      FROM `lk-datawarehouse-2.tenjin_dv.events` events
      WHERE events.created_at >= (TIMESTAMP('2021-08-20 00:00:00'))
      AND events.created_at < (TIMESTAMP('2021-09-14 00:00:00'))
      AND events.bundle_id  = 'com.luckykat.matchz'
      -- AND events.platform  = 'android'
      group by 1,2,3,4) tenjin_base
      LEFT JOIN(
      SELECT
            *
          FROM (
            SELECT
              ad_network_id,
              campaign_bucket_id,
              remote_campaign_id,
              app_id,
              name AS campaign_name,
              id AS campaign_id,
              network_name
            FROM `lk-datawarehouse-2.tenjin_dv.campaigns` tenjin_campaigns
            LEFT JOIN (
              SELECT
                id AS network_id,
                name AS network_name
              FROM`lk-datawarehouse-2.tenjin_dv.ad_networks`)tenjin_networks
              ON tenjin_campaigns.ad_network_id = tenjin_networks.network_id ))tenjin_attribution
        ON
          tenjin_base.source_campaign_id = tenjin_attribution.campaign_id ) tenjin
      on lower(replace(firebase.firebase_id,"-",""))= tenjin.tenjin_id
      and lower(firebase.firebase_platform) = tenjin.platform
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13
      -- )
      -- group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: date {
    type: time
    timeframes: [date, week, day_of_week, month, year]
    sql: TIMESTAMP(PARSE_DATE('%Y%m%d',(${TABLE}.date))) ;;
  }

  dimension: network_name {
    type: string
    sql: ${TABLE}.network_name ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }

  dimension: firebase_platform {
    type: string
    sql: ${TABLE}.firebase_platform ;;
  }

  dimension_group: user_first_touch {
    description: "The time at which the user first opened the app."
    timeframes: [raw,time,hour,minute,date, week, day_of_week, month, year]
    type: time
    sql: TIMESTAMP_MICROS(${TABLE}.user_first_touch_timestamp) ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: cohort_day {
    type: number
    sql: DATE_DIFF(${date_date},${user_first_touch_date},DAY) ;;
  }

  measure: dau {
    type: count_distinct
    sql: ${TABLE}.user_pseudo_id ;;
  }

  measure: banner_revenue {
    type: sum
    sql: ${TABLE}.banner_revenue ;;
    value_format: "$#.##"
  }

  measure: interstitial_revenue {
    type: sum
    sql: ${TABLE}.interstitial_revenue ;;
    value_format: "$#.##"

  }

  measure: rewarded_revenue {
    type: sum
    sql: ${TABLE}.rewarded_revenue ;;
    value_format: "$#.##"

  }

  measure: ad_revenue {
    type: number
    sql: ${banner_revenue}+${interstitial_revenue}+${rewarded_revenue} ;;
    value_format: "$#.##"
  }

  measure: engagement_time {
    type: sum
    sql: ${TABLE}.engagement_time ;;
  }

  set: detail {
    fields: [
      network_name,
      campaign_name,
      creative_name,
      firebase_platform,
      country,
      cohort_day,
      dau,
      banner_revenue,
      interstitial_revenue,
      rewarded_revenue,
      engagement_time
    ]
  }
}
