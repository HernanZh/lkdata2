view: games {
  sql_table_name: `gameanalytics.games`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: access_level {
    type: number
    sql: ${TABLE}.access_level ;;
  }

  dimension: access_role {
    type: string
    sql: ${TABLE}.access_role ;;
  }

  dimension: amazon_key {
    type: string
    sql: ${TABLE}.amazon_key ;;
  }

  dimension: archived {
    type: yesno
    sql: ${TABLE}.archived ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: created_timestamp {
    type: number
    sql: ${TABLE}.createdTimestamp ;;
  }

  dimension: data_api_token_exp {
    type: number
    sql: ${TABLE}.dataApiToken_exp ;;
  }

  dimension: data_api_token_token {
    type: string
    sql: ${TABLE}.dataApiToken_token ;;
  }

  dimension: disabled {
    type: yesno
    sql: ${TABLE}.disabled ;;
  }

  dimension: feature_flags {
    type: string
    sql: ${TABLE}.featureFlags ;;
  }

  dimension: game_key {
    type: string
    sql: ${TABLE}.game_key ;;
  }

  dimension: genres_0 {
    type: number
    sql: ${TABLE}.genres_0 ;;
  }

  dimension: genres_1 {
    type: number
    sql: ${TABLE}.genres_1 ;;
  }

  dimension: genres_2 {
    type: number
    sql: ${TABLE}.genres_2 ;;
  }

  dimension: genres_3 {
    type: number
    sql: ${TABLE}.genres_3 ;;
  }

  dimension: genres_4 {
    type: number
    sql: ${TABLE}.genres_4 ;;
  }

  dimension: googleplay_key {
    type: string
    sql: ${TABLE}.googleplay_key ;;
  }

  dimension: image_file {
    type: string
    sql: ${TABLE}.imageFile ;;
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

  dimension: is_beta_game {
    type: yesno
    sql: ${TABLE}.is_beta_game ;;
  }

  dimension: link_game_notification {
    type: yesno
    sql: ${TABLE}.link_game_notification ;;
  }

  dimension: new_event_structure_status {
    type: number
    sql: ${TABLE}.newEventStructureStatus ;;
  }

  dimension: onboarding_benchmarks_genres {
    type: yesno
    sql: ${TABLE}.onboarding_benchmarks_genres ;;
  }

  dimension: onboarding_prompt_app_store_connect {
    type: number
    sql: ${TABLE}.onboarding_prompt_app_store_connect ;;
  }

  dimension: onboarding_update_game_1 {
    type: yesno
    sql: ${TABLE}.onboarding_update_game_1 ;;
  }

  dimension: store_app {
    type: string
    sql: ${TABLE}.store_app ;;
  }

  dimension: store_app_app_title {
    type: string
    sql: ${TABLE}.store_app_app_title ;;
  }

  dimension: store_app_categories_0_device {
    type: string
    sql: ${TABLE}.store_app_categories_0_device ;;
  }

  dimension: store_app_categories_0_id {
    type: number
    sql: ${TABLE}.store_app_categories_0_id ;;
  }

  dimension: store_app_categories_0_name {
    type: string
    sql: ${TABLE}.store_app_categories_0_name ;;
  }

  dimension: store_app_categories_0_store {
    type: string
    sql: ${TABLE}.store_app_categories_0_store ;;
  }

  dimension: store_app_categories_1_device {
    type: string
    sql: ${TABLE}.store_app_categories_1_device ;;
  }

  dimension: store_app_categories_1_id {
    type: number
    sql: ${TABLE}.store_app_categories_1_id ;;
  }

  dimension: store_app_categories_1_name {
    type: string
    sql: ${TABLE}.store_app_categories_1_name ;;
  }

  dimension: store_app_categories_1_store {
    type: string
    sql: ${TABLE}.store_app_categories_1_store ;;
  }

  dimension: store_app_categories_2_device {
    type: string
    sql: ${TABLE}.store_app_categories_2_device ;;
  }

  dimension: store_app_categories_2_id {
    type: number
    sql: ${TABLE}.store_app_categories_2_id ;;
  }

  dimension: store_app_categories_2_name {
    type: string
    sql: ${TABLE}.store_app_categories_2_name ;;
  }

  dimension: store_app_categories_2_store {
    type: string
    sql: ${TABLE}.store_app_categories_2_store ;;
  }

  dimension: store_app_categories_3_device {
    type: string
    sql: ${TABLE}.store_app_categories_3_device ;;
  }

  dimension: store_app_categories_3_id {
    type: number
    sql: ${TABLE}.store_app_categories_3_id ;;
  }

  dimension: store_app_categories_3_name {
    type: string
    sql: ${TABLE}.store_app_categories_3_name ;;
  }

  dimension: store_app_categories_3_store {
    type: string
    sql: ${TABLE}.store_app_categories_3_store ;;
  }

  dimension: store_app_categories_4_device {
    type: string
    sql: ${TABLE}.store_app_categories_4_device ;;
  }

  dimension: store_app_categories_4_id {
    type: number
    sql: ${TABLE}.store_app_categories_4_id ;;
  }

  dimension: store_app_categories_4_name {
    type: string
    sql: ${TABLE}.store_app_categories_4_name ;;
  }

  dimension: store_app_categories_4_store {
    type: string
    sql: ${TABLE}.store_app_categories_4_store ;;
  }

  dimension: store_app_categories_5_device {
    type: string
    sql: ${TABLE}.store_app_categories_5_device ;;
  }

  dimension: store_app_categories_5_id {
    type: number
    sql: ${TABLE}.store_app_categories_5_id ;;
  }

  dimension: store_app_categories_5_name {
    type: string
    sql: ${TABLE}.store_app_categories_5_name ;;
  }

  dimension: store_app_categories_5_store {
    type: string
    sql: ${TABLE}.store_app_categories_5_store ;;
  }

  dimension: store_app_categories_6_device {
    type: string
    sql: ${TABLE}.store_app_categories_6_device ;;
  }

  dimension: store_app_categories_6_id {
    type: number
    sql: ${TABLE}.store_app_categories_6_id ;;
  }

  dimension: store_app_categories_6_name {
    type: string
    sql: ${TABLE}.store_app_categories_6_name ;;
  }

  dimension: store_app_categories_6_store {
    type: string
    sql: ${TABLE}.store_app_categories_6_store ;;
  }

  dimension: store_app_developer {
    type: string
    sql: ${TABLE}.store_app_developer ;;
  }

  dimension: store_app_game_id {
    type: number
    sql: ${TABLE}.store_app_game_id ;;
  }

  dimension: store_app_game_type {
    type: string
    sql: ${TABLE}.store_app_game_type ;;
  }

  dimension: store_app_id {
    type: number
    sql: ${TABLE}.store_app_id ;;
  }

  dimension: store_app_image_url {
    type: string
    sql: ${TABLE}.store_app_image_url ;;
  }

  dimension: store_app_not_found {
    type: yesno
    sql: ${TABLE}.store_app_not_found ;;
  }

  dimension: store_app_price {
    type: number
    sql: ${TABLE}.store_app_price ;;
  }

  dimension: store_app_store_age_restriction {
    type: number
    sql: ${TABLE}.store_app_store_age_restriction ;;
  }

  dimension: store_app_store_id {
    type: string
    sql: ${TABLE}.store_app_store_id ;;
  }

  dimension: store_app_store_name {
    type: string
    sql: ${TABLE}.store_app_store_name ;;
  }

  dimension: store_app_store_url {
    type: string
    sql: ${TABLE}.store_app_store_url ;;
  }

  dimension: store_platform {
    type: string
    sql: ${TABLE}.store_platform ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      store_app_categories_1_name,
      store_app_store_name,
      store_app_categories_6_name,
      store_app_categories_4_name,
      store_app_categories_3_name,
      store_app_categories_2_name,
      store_app_categories_5_name,
      store_app_categories_0_name
    ]
  }
}
