view: games_details_design {
  sql_table_name: `lk-datawarehouse-2.gameanalytics.games_details_design`
    ;;

  dimension: arrival_ts {
    type: number
    sql: ${TABLE}.arrival_ts ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: data_ab_id {
    type: string
    sql: ${TABLE}.data_ab_id ;;
  }

  dimension: data_ab_variant_id {
    type: string
    sql: ${TABLE}.data_ab_variant_id ;;
  }

  dimension: data_amount {
    type: number
    sql: ${TABLE}.data_amount ;;
  }

  dimension: data_amount_usd {
    type: number
    sql: ${TABLE}.data_amount_usd ;;
  }

  dimension: data_android_app_build {
    type: string
    sql: ${TABLE}.data_android_app_build ;;
  }

  dimension: data_android_app_signature {
    type: string
    sql: ${TABLE}.data_android_app_signature ;;
  }

  dimension: data_android_app_version {
    type: string
    sql: ${TABLE}.data_android_app_version ;;
  }

  dimension: data_android_bundle_id {
    type: string
    sql: ${TABLE}.data_android_bundle_id ;;
  }

  dimension: data_android_channel_id {
    type: string
    sql: ${TABLE}.data_android_channel_id ;;
  }

  dimension: data_android_hdw_serial {
    type: string
    sql: ${TABLE}.data_android_hdw_serial ;;
  }

  dimension: data_android_id {
    type: string
    sql: ${TABLE}.data_android_id ;;
  }

  dimension: data_android_imei {
    type: string
    sql: ${TABLE}.data_android_imei ;;
  }

  dimension: data_android_mac_md5 {
    type: string
    sql: ${TABLE}.data_android_mac_md5 ;;
  }

  dimension: data_android_mac_sha1 {
    type: string
    sql: ${TABLE}.data_android_mac_sha1 ;;
  }

  dimension: data_attempt_num {
    type: number
    sql: ${TABLE}.data_attempt_num ;;
  }

  dimension: data_browser_version {
    type: string
    sql: ${TABLE}.data_browser_version ;;
  }

  dimension: data_build {
    type: string
    sql: ${TABLE}.data_build ;;
  }

  dimension: data_cart_type {
    type: string
    sql: ${TABLE}.data_cart_type ;;
  }

  dimension: data_category {
    type: string
    sql: ${TABLE}.data_category ;;
  }

  dimension: data_client_ts {
    type: number
    sql: ${TABLE}.data_client_ts ;;
  }

  dimension: data_configuration_keys_0 {
    type: string
    sql: ${TABLE}.data_configuration_keys_0 ;;
  }

  dimension: data_configuration_keys_1 {
    type: string
    sql: ${TABLE}.data_configuration_keys_1 ;;
  }

  dimension: data_configuration_keys_2 {
    type: string
    sql: ${TABLE}.data_configuration_keys_2 ;;
  }

  dimension: data_configuration_keys_3 {
    type: string
    sql: ${TABLE}.data_configuration_keys_3 ;;
  }

  dimension: data_configuration_keys_4 {
    type: string
    sql: ${TABLE}.data_configuration_keys_4 ;;
  }

  dimension: data_configurations_0 {
    type: string
    sql: ${TABLE}.data_configurations_0 ;;
  }

  dimension: data_configurations_1 {
    type: string
    sql: ${TABLE}.data_configurations_1 ;;
  }

  dimension: data_configurations_2 {
    type: string
    sql: ${TABLE}.data_configurations_2 ;;
  }

  dimension: data_configurations_3 {
    type: string
    sql: ${TABLE}.data_configurations_3 ;;
  }

  dimension: data_configurations_4 {
    type: string
    sql: ${TABLE}.data_configurations_4 ;;
  }

  dimension: data_connection_type {
    type: string
    sql: ${TABLE}.data_connection_type ;;
  }

  dimension: data_currency {
    type: string
    sql: ${TABLE}.data_currency ;;
  }

  dimension: data_custom_01 {
    type: string
    sql: ${TABLE}.data_custom_01 ;;
  }

  dimension: data_custom_02 {
    type: string
    sql: ${TABLE}.data_custom_02 ;;
  }

  dimension: data_custom_03 {
    type: string
    sql: ${TABLE}.data_custom_03 ;;
  }

  dimension: data_custom_04 {
    type: string
    sql: ${TABLE}.data_custom_04 ;;
  }

  dimension: data_custom_05 {
    type: string
    sql: ${TABLE}.data_custom_05 ;;
  }

  dimension: data_device {
    type: string
    sql: ${TABLE}.data_device ;;
  }

  dimension: data_engine_version {
    type: string
    sql: ${TABLE}.data_engine_version ;;
  }

  dimension: data_error_action {
    type: string
    sql: ${TABLE}.data_error_action ;;
  }

  dimension: data_error_area {
    type: string
    sql: ${TABLE}.data_error_area ;;
  }

  dimension: data_error_category {
    type: string
    sql: ${TABLE}.data_error_category ;;
  }

  dimension: data_error_parameter {
    type: string
    sql: ${TABLE}.data_error_parameter ;;
  }

  dimension: data_event_id {
    type: string
    sql: ${TABLE}.data_event_id ;;
  }

  dimension: data_google_aid {
    type: string
    sql: ${TABLE}.data_google_aid ;;
  }

  dimension: data_google_aid_src {
    type: string
    sql: ${TABLE}.data_google_aid_src ;;
  }

  dimension: data_install {
    type: yesno
    sql: ${TABLE}.data_install ;;
  }

  dimension: data_ios_app_build {
    type: string
    sql: ${TABLE}.data_ios_app_build ;;
  }

  dimension: data_ios_app_version {
    type: string
    sql: ${TABLE}.data_ios_app_version ;;
  }

  dimension: data_ios_bundle_id {
    type: string
    sql: ${TABLE}.data_ios_bundle_id ;;
  }

  dimension: data_ios_idfa {
    type: string
    sql: ${TABLE}.data_ios_idfa ;;
  }

  dimension: data_ios_idfv {
    type: string
    sql: ${TABLE}.data_ios_idfv ;;
  }

  dimension: data_jailbroken {
    type: yesno
    sql: ${TABLE}.data_jailbroken ;;
  }

  dimension: data_length {
    type: number
    sql: ${TABLE}.data_length ;;
  }

  dimension: data_limited_ad_tracking {
    type: yesno
    sql: ${TABLE}.data_limited_ad_tracking ;;
  }

  dimension: data_manufacturer {
    type: string
    sql: ${TABLE}.data_manufacturer ;;
  }

  dimension: data_message {
    type: string
    sql: ${TABLE}.data_message ;;
  }

  dimension: data_os_version {
    type: string
    sql: ${TABLE}.data_os_version ;;
  }

  dimension: data_platform {
    type: string
    sql: ${TABLE}.data_platform ;;
  }

  dimension: data_reason {
    type: string
    sql: ${TABLE}.data_reason ;;
  }

  dimension: data_receipt_info_receipt {
    type: string
    sql: ${TABLE}.data_receipt_info_receipt ;;
  }

  dimension: data_receipt_info_receipt_id {
    type: string
    sql: ${TABLE}.data_receipt_info_receipt_id ;;
  }

  dimension: data_receipt_info_signature {
    type: string
    sql: ${TABLE}.data_receipt_info_signature ;;
  }

  dimension: data_receipt_info_store {
    type: string
    sql: ${TABLE}.data_receipt_info_store ;;
  }

  dimension: data_score {
    type: number
    sql: ${TABLE}.data_score ;;
  }

  dimension: data_sdk_version {
    type: string
    sql: ${TABLE}.data_sdk_version ;;
  }

  dimension: data_session_id {
    type: string
    sql: ${TABLE}.data_session_id ;;
  }

  dimension: data_session_num {
    type: number
    sql: ${TABLE}.data_session_num ;;
  }

  dimension: data_severity {
    type: string
    sql: ${TABLE}.data_severity ;;
  }

  dimension: data_transaction_num {
    type: number
    sql: ${TABLE}.data_transaction_num ;;
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}.data_type ;;
  }

  dimension: data_user_id {
    type: string
    sql: ${TABLE}.data_user_id ;;
  }

  dimension: data_v {
    type: number
    sql: ${TABLE}.data_v ;;
  }

  dimension: data_value {
    type: number
    sql: ${TABLE}.data_value ;;
  }

  dimension: first_in_batch {
    type: yesno
    sql: ${TABLE}.first_in_batch ;;
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

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: multi_message {
    type: yesno
    sql: ${TABLE}.multi_message ;;
  }

  dimension: public_key {
    type: string
    sql: ${TABLE}.public_key ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}
