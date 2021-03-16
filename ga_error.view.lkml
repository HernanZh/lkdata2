view: ga_error {
  sql_table_name: `lk-datawarehouse-2.gameanalytics.GA_error`
    ;;

  dimension: ab_id {
    type: string
    sql: ${TABLE}.ab_id ;;
  }

  dimension: ab_variant_id {
    type: string
    sql: ${TABLE}.ab_variant_id ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: amount_usd {
    type: number
    sql: ${TABLE}.amount_usd ;;
  }

  dimension: android_app_build {
    type: string
    sql: ${TABLE}.android_app_build ;;
  }

  dimension: android_app_signature {
    type: string
    sql: ${TABLE}.android_app_signature ;;
  }

  dimension: android_app_version {
    type: string
    sql: ${TABLE}.android_app_version ;;
  }

  dimension: android_bundle_id {
    type: string
    sql: ${TABLE}.android_bundle_id ;;
  }

  dimension: android_channel_id {
    type: string
    sql: ${TABLE}.android_channel_id ;;
  }

  dimension: android_hdw_serial {
    type: string
    sql: ${TABLE}.android_hdw_serial ;;
  }

  dimension: android_id {
    type: string
    sql: ${TABLE}.android_id ;;
  }

  dimension: android_imei {
    type: string
    sql: ${TABLE}.android_imei ;;
  }

  dimension: android_mac_md5 {
    type: string
    sql: ${TABLE}.android_mac_md5 ;;
  }

  dimension: android_mac_sha1 {
    type: string
    sql: ${TABLE}.android_mac_sha1 ;;
  }

  dimension: arrival_ts {
    type: number
    sql: ${TABLE}.arrival_ts ;;
  }

  dimension: attempt_num {
    type: number
    sql: ${TABLE}.attempt_num ;;
  }

  dimension: browser_version {
    type: string
    sql: ${TABLE}.browser_version ;;
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

  dimension: client_ts {
    type: number
    sql: ${TABLE}.client_ts ;;
  }

  dimension: configuration_keys_0 {
    type: string
    sql: ${TABLE}.configuration_keys_0 ;;
  }

  dimension: configuration_keys_1 {
    type: string
    sql: ${TABLE}.configuration_keys_1 ;;
  }

  dimension: configuration_keys_2 {
    type: string
    sql: ${TABLE}.configuration_keys_2 ;;
  }

  dimension: configuration_keys_3 {
    type: string
    sql: ${TABLE}.configuration_keys_3 ;;
  }

  dimension: configuration_keys_4 {
    type: string
    sql: ${TABLE}.configuration_keys_4 ;;
  }

  dimension: configurations_0 {
    type: string
    sql: ${TABLE}.configurations_0 ;;
  }

  dimension: configurations_1 {
    type: string
    sql: ${TABLE}.configurations_1 ;;
  }

  dimension: configurations_2 {
    type: string
    sql: ${TABLE}.configurations_2 ;;
  }

  dimension: configurations_3 {
    type: string
    sql: ${TABLE}.configurations_3 ;;
  }

  dimension: configurations_4 {
    type: string
    sql: ${TABLE}.configurations_4 ;;
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

  dimension: engine_version {
    type: string
    sql: ${TABLE}.engine_version ;;
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

  dimension: error_parameter {
    type: string
    sql: ${TABLE}.error_parameter ;;
  }

  dimension: event_id {
    type: string
    sql: ${TABLE}.event_id ;;
  }

  dimension: first_in_batch {
    type: yesno
    sql: ${TABLE}.first_in_batch ;;
  }

  dimension: game_id {
    type: number
    sql: ${TABLE}.game_id ;;
  }

  dimension: google_aid {
    type: string
    sql: ${TABLE}.google_aid ;;
  }

  dimension: google_aid_src {
    type: string
    sql: ${TABLE}.google_aid_src ;;
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

  dimension: install {
    type: yesno
    sql: ${TABLE}.install ;;
  }

  dimension: ios_app_build {
    type: string
    sql: ${TABLE}.ios_app_build ;;
  }

  dimension: ios_app_version {
    type: string
    sql: ${TABLE}.ios_app_version ;;
  }

  dimension: ios_bundle_id {
    type: string
    sql: ${TABLE}.ios_bundle_id ;;
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

  dimension: jailbroken {
    type: yesno
    sql: ${TABLE}.jailbroken ;;
  }


  dimension: limited_ad_tracking {
    type: yesno
    sql: ${TABLE}.limited_ad_tracking ;;
  }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
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

  dimension: public_key {
    type: string
    sql: ${TABLE}.public_key ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: receipt_info_receipt {
    type: string
    sql: ${TABLE}.receipt_info_receipt ;;
  }

  dimension: receipt_info_receipt_id {
    type: string
    sql: ${TABLE}.receipt_info_receipt_id ;;
  }

  dimension: receipt_info_signature {
    type: string
    sql: ${TABLE}.receipt_info_signature ;;
  }

  dimension: receipt_info_store {
    type: string
    sql: ${TABLE}.receipt_info_store ;;
  }

  dimension: score {
    type: number
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

  dimension: user_meta_install_ts {
    type: number
    sql: ${TABLE}.user_meta_install_ts ;;
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

  dimension: user_meta_receipt_status {
    type: string
    sql: ${TABLE}.user_meta_receipt_status ;;
  }

  dimension: user_meta_revenue {
    type: string
    sql: ${TABLE}.user_meta_revenue ;;
  }

  dimension: v {
    type: number
    sql: ${TABLE}.v ;;
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
