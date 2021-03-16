view: GA_error {
  sql_table_name: gameanalytics.GA_error
    ;;

  dimension: bundle_id {
    type: string
    sql: CASE WHEN ${TABLE}.platform = 'ios' THEN ios_bundle_id
          WHEN ${TABLE}.platform = 'android' THEN android_bundle_id
          ELSE ios_bundle_id END;;
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

  dimension: build {
    type: string
    sql: ${TABLE}.build ;;
  }

  dimension: cart_type {
    type: string
    sql: ${TABLE}.cart_type ;;
  }

  dimension: client_ts {
    type: number
    sql: ${TABLE}.client_ts ;;
  }

  dimension: connection_type {
    type: string
    sql: ${TABLE}.connection_type ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
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

  dimension: custom_04 {
    type: string
    sql: ${TABLE}.custom_04 ;;
  }

  dimension: custom_05 {
    type: string
    sql: ${TABLE}.custom_05 ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: event_id {
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension: game_id {
    type: number
    sql: ${TABLE}.game_id ;;
  }

  dimension_group: inserted {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.inserted_at ;;
  }

  dimension: ios_app_version {
    type: string
    sql: ${TABLE}.ios_app_version ;;
  }

  dimension: ios_idfa {
    type: string
    sql: ${TABLE}.ios_idfa ;;
  }

  dimension: ios_idfv {
    type: string
    sql: ${TABLE}.ios_idfv ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: limited_ad_tracking {
    type: yesno
    sql: ${TABLE}.limited_ad_tracking ;;
  }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: multi_message {
    type: yesno
    sql: ${TABLE}.multi_message ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: sdk_version {
    type: string
    sql: ${TABLE}.sdk_version ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_num {
    type: number
    sql: ${TABLE}.session_num ;;
  }

  dimension: transaction_num {
    type: number
    sql: ${TABLE}.transaction_num ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_meta_attribution_partner {
    type: string
    sql: ${TABLE}.user_meta_attribution_partner ;;
  }

  dimension: user_meta_cohort_month {
    type: number
    sql: ${TABLE}.user_meta_cohort_month ;;
  }

  dimension: user_meta_cohort_week {
    type: number
    sql: ${TABLE}.user_meta_cohort_week ;;
  }

  dimension: user_meta_first_build {
    type: string
    sql: ${TABLE}.user_meta_first_build ;;
  }

  dimension: user_meta_install_campaign {
    type: string
    sql: ${TABLE}.user_meta_install_campaign ;;
  }

  dimension: user_meta_install_hour {
    type: number
    sql: ${TABLE}.user_meta_install_hour ;;
  }

  dimension: user_meta_install_publisher {
    type: string
    sql: ${TABLE}.user_meta_install_publisher ;;
  }

  dimension: user_meta_install_site {
    type: string
    sql: ${TABLE}.user_meta_install_site ;;
  }

  dimension_group: since_install {
    type: duration
    intervals: [day]
    sql_start: ${install_ts_date::datetime} ;;
    sql_end: ${arrival_ts_date::datetime} ;;
  }

  dimension: user_meta_origin {
    type: string
    sql: ${TABLE}.user_meta_origin ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  measure: DAU {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: session_count {
    type: count_distinct
    sql: ${TABLE}.session_id ;;
  }

  measure: avg_value {
    type: average
    sql: ${TABLE}.value ;;
  }

  measure: sum_value {
    type: sum
    sql: ${TABLE}.value ;;
  }

#String of error message
  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
