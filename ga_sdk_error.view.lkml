view: GA_sdk_error {
  sql_table_name: gameanalytics.GA_sdk_error
    ;;
  #ONLY HAS GAME ID
  # dimension: bundle_id {
  #   type: string
  #   sql: CASE WHEN ${TABLE}.platform = 'ios' THEN ios_bundle_id
  #         WHEN ${TABLE}.platform = 'android' THEN android_bundle_id
  #         ELSE ios_bundle_id END;;
  # }

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

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
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


  dimension: error_action {
    type: string
    sql: ${TABLE}.error_action ;;
  }

  dimension: error_area {
    type: string
    sql: ${TABLE}.error_area ;;
  }

  dimension: error_category {
    type: string
    sql: ${TABLE}.error_category ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }


  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
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

  dimension: transaction_num {
    type: number
    sql: ${TABLE}.transaction_num ;;
  }


  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}
