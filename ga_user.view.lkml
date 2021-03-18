view: GA_user{
  sql_table_name: gameanalytics.GA_user
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

  dimension_group: client_ts {
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
    sql: TIMESTAMP_SECONDS(${TABLE}.client_ts) ;;
  }

  dimension: connection_type {
    type: string
    sql: ${TABLE}.connection_type ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
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

  dimension: user_meta_install_campaign {
    type: string
    sql: ${TABLE}.user_meta_install_campaign ;;
  }

  dimension_group: since_install {
    type: duration
    intervals: [day]
    sql_start: ${install_ts_date::datetime} ;;
    sql_end: ${arrival_ts_date::datetime} ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  dimension: attempt_num {
    type: number
    sql: ${TABLE}.attempt_num ;;
  }

  #Should be aggregated?
  measure: score {
    type: sum
    sql: ${TABLE}.score ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}
