view: game_analytics {
  #sql_table_name: gameanalytics.GA_view ;;
  sql_table_name: game_analytics.data_export_new;;

  measure: amount {
    type: sum
    sql: ${TABLE}.amount ;;
  }

  dimension: android_id {
    type: string
    sql: ${TABLE}.android_id ;;
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

  dimension: attempt_num {
    type: number
    sql: ${TABLE}.attempt_num ;;
  }

  dimension: birth_year {
    type: string
    sql: ${TABLE}.birth_year ;;
  }

  dimension: build {
    type: string
    sql: ${TABLE}.build ;;
  }

  dimension: cart_type {
    type: string
    sql: ${TABLE}.cart_type ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
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

  dimension: cohort_month {
    type: number
    sql: ${TABLE}.cohort_month ;;
  }

  dimension: cohort_week {
    type: number
    sql: ${TABLE}.cohort_week ;;
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

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: engine_version {
    type: string
    sql: ${TABLE}.engine_version ;;
  }

  dimension: event_id {
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension: facebook_id {
    type: string
    sql: ${TABLE}.facebook_id ;;
  }

  dimension: first_build {
    type: string
    sql: ${TABLE}.first_build ;;
  }

  dimension: first_in_batch {
    type: yesno
    sql: ${TABLE}.first_in_batch ;;
  }

  dimension: game_id {
    type: number
    sql: ${TABLE}.game_id ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: google_aid {
    type: string
    sql: ${TABLE}.google_aid ;;
  }

  dimension: googleplus_id {
    type: string
    sql: ${TABLE}.googleplus_id ;;
  }

  dimension: inserted_at {
    type: date_time
    sql: ${TABLE}.inserted_at ;;
  }

  dimension_group: inserted_at {
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
    datatype: date
    sql: ${TABLE}.inserted_at ;;
  }

  dimension: install_campaign {
    type: string
    sql: ${TABLE}.install_campaign ;;
  }

  dimension: install_hour {
    type: number
    sql: ${TABLE}.install_hour ;;
  }

  dimension: install_publisher {
    type: string
    sql: ${TABLE}.install_publisher ;;
  }

  dimension: install_site {
    type: string
    sql: ${TABLE}.install_site ;;
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
    sql: TIMESTAMP_SECONDS(${TABLE}.user_meta_install_ts) ;;
  }

  dimension: ios_app_build {
    type: string
    sql: ${TABLE}.ios_app_build ;;
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

  dimension: is_converting {
    type: string
    sql: ${TABLE}.is_converting ;;
  }

  dimension: jailbroken {
    type: yesno
    sql: ${TABLE}.jailbroken ;;
  }

  dimension: length {
    type: number
    sql: ${TABLE}.length ;;
  }

  dimension: limited_ad_tracking {
    type: yesno
    sql: ${TABLE}.limited_ad_tracking ;;
  }

  dimension: logon_gamecenter {
    type: yesno
    sql: ${TABLE}.logon_gamecenter ;;
  }

  dimension: logon_googleplay {
    type: yesno
    sql: ${TABLE}.logon_googleplay ;;
  }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  measure: score {
    type: sum
    sql: ${TABLE}.score ;;
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

  dimension: severity {
    type: string
    sql: ${TABLE}.severity ;;
  }

  dimension: transaction_num {
    type: number
    sql: ${TABLE}.transaction_num ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: v {
    type: number
    sql: ${TABLE}.v ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  # dimension: bundle_id {
  #   type: string
  #   sql: CASE WHEN ${TABLE}.platform = 'ios' THEN ios_bundle_id
  #   WHEN ${TABLE}.platform = 'android' THEN android_bundle_id
  #   ELSE ios_bundle_id END;;
  # # ${TABLE}.bundle_id ;;
  # # sql: ${TABLE}.data_ios_bundle_id
  # }

  measure: count {
    type: count
    drill_fields: []
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

  dimension_group: since_install {
    type: duration
    intervals: [day]
    sql_start: ${install_ts_date::datetime} ;;
    sql_end: ${arrival_ts_date::datetime} ;;
  }
}
