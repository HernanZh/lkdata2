view: GA_session_end_new {
  sql_table_name: gameanalytics.GA_session_end_NEW
    ;;

  dimension_group: arrival {
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
    sql: ${TABLE}.arrival_date ;;
  }

  dimension: bundle_id {
    type: string
    sql: CASE WHEN ${TABLE}.platform = 'ios' THEN ios_bundle_id
          WHEN ${TABLE}.platform = 'android' THEN android_bundle_id
          ELSE ios_bundle_id END;;
  }

  dimension: ios_bundle_id {
    type: string
    sql: ${TABLE}.ios_bundle_id ;;
  }

  dimension: android_bundle_id {
    type: string
    sql: ${TABLE}.android_bundle_id ;;
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

  dimension: country_bucket {
    type: string
    case: {
      when: {
        sql: ${TABLE}.country_code IN ('AU','CA','DE','NZ','NO','CH', 'GB') ;;
        label: "T1"
      }
      when: {
        sql: ${TABLE}.country_code IN ('HK','JP','KR','TW') ;;
        label: "T1_LOC"
      }
      when: {
        sql: ${TABLE}.country_code IN ('AT','BE','DK','FR','NL','SG','SE') ;;
        label: "T2"
      }
      when: {
        sql: ${TABLE}.country_code IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN') ;;
        label: "T3"
      }
      when: {
        sql: ${TABLE}.country_code IN ('US') ;;
        label: "US"
      }
      when: {
        sql: ${TABLE}.country_code IN ('CN') ;;
        label: "CN"
      }
      else: "Unknown"
    }
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

  dimension: length {
    type: number
    sql: ${TABLE}.length ;;
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



  dimension: user_meta_is_converting {
    type: yesno
    sql: ${TABLE}.user_meta_is_converting ;;
  }

  dimension: user_meta_is_paying {
    type: yesno
    sql: ${TABLE}.user_meta_is_paying ;;
  }

  dimension: user_meta_origin {
    type: string
    sql: ${TABLE}.user_meta_origin ;;
  }

  dimension: user_meta_pay_ft {
    type: number
    sql: ${TABLE}.user_meta_pay_ft ;;
  }

  dimension: user_meta_revenue {
    type: string
    sql: ${TABLE}.user_meta_revenue ;;
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
  dimension: score {
    type: number
    sql: ${TABLE}.attempt_num ;;
  }

  measure: DAU {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: session_count {
    type: count_distinct
    sql: ${TABLE}.session_id ;;
  }
  measure: avg_session_length {
    type: average
    sql: ${TABLE}.length ;;
  }

  measure: avg_value {
    type: average
    sql: ${TABLE}.value ;;
  }

  measure: sum_value {
    type: sum
    sql: ${TABLE}.value ;;
  }

  measure: playtime {
    type: number
    sql: ${session_count} * ${avg_session_length} / ${DAU} ;;
  }

  # measure: total_playtime {
  #   type: sum
  #   sql: (${playtime});;
  # }


  measure: count {
    type: count
    drill_fields: []
  }
}
