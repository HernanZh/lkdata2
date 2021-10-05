view: rh_attribution {
  sql_table_name: `events_*`  ;;

### app info
  dimension: app_info {
    hidden: yes
    sql: ${TABLE}.app_info ;;
  }

  dimension: id {
    group_label: "App Info"
    description: "The package name or bundle ID of the app."
    type: string
    sql: ${app_info}.id ;;
  }

  dimension: firebase_app_id {
    group_label: "App Info"
    description: "The Firebase App ID associated with the app"
    type: string
    sql: ${app_info}.firebase_app_id ;;
  }

  dimension: install_source {
    group_label: "App Info"
    description: "The store that installed the app."
    type: string
    sql: ${app_info}.install_source ;;
  }

  dimension: version {
    group_label: "App Info"
    description: "The app's versionName (Android) or short bundle version."
    type: string
    sql: ${app_info}.version ;;
  }

### end app info

  dimension: ad_impression_revenue {
    type: number
    sql:(select value.double_value from UNNEST(${TABLE}.event_params) where value.double_value IS NOT NULL) ;;
  }

  measure: sum_revenue {
    type: sum
    sql: ${ad_impression_revenue} ;;
    value_format: "$#.##"
  }

  measure: ARPDAU {
    type: number
    sql: ${sum_revenue}/${number_of_users} ;;
    value_format: "$#.###"
  }

  dimension: int_values {
    type: number
    sql:(select value.int_value from UNNEST(${TABLE}.event_params) where value.int_value IS NOT NULL AND key = 'value') ;;
  }

  measure: int_sum {
    type: sum
    sql: ${int_values} ;;
    # value_format: "$#.##"
  }

  measure: engagement_time {
    type: sum
    sql:(SELECT value.int_value
        FROM UNNEST(${TABLE}.event_params)
        WHERE key = "engagement_time_msec"
       ) ;;
  }

### device dimensions

  dimension: device {
    hidden: yes
    sql: ${TABLE}.device ;;
  }

  dimension: advertising_id {
    group_label: "Device"
    description: "Advertising ID/IDFA."
    type: string
    sql: ${device}.advertising_id ;;
    # primary_key: yes
  }

  dimension: browser {
    group_label: "Device"
    type: string
    sql: ${device}.browser ;;
  }

  dimension: browser_version {
    group_label: "Device"
    type: string
    sql: ${device}.browser_version ;;
  }

  dimension: category {
    description: "The device category (mobile, tablet, desktop)."
    group_label: "Device"
    type: string
    sql: ${device}.category ;;
  }

  dimension: is_limited_ad_tracking {
    group_label: "Device"
    description: "The device's Limit Ad Tracking setting."
    type: string
    sql: ${device}.is_limited_ad_tracking ;;
  }

  dimension: language {
    group_label: "Device"
    description: "The OS language."
    type: string
    sql: ${device}.language ;;
  }

  dimension: mobile_brand_name {
    group_label: "Device"
    description: "The device brand name."
    type: string
    sql: ${device}.mobile_brand_name ;;
  }

  dimension: mobile_marketing_name {
    group_label: "Device"
    description: "The device marketing name."
    type: string
    sql: ${device}.mobile_marketing_name ;;
  }

  dimension: mobile_model_name {
    group_label: "Device"
    description: "The device model name."
    type: string
    sql: ${device}.mobile_model_name ;;
  }

  dimension: mobile_os_hardware_model {
    group_label: "Device"
    description: "The device model information retrieved directly from the operating system."
    type: string
    sql: ${device}.mobile_os_hardware_model ;;
  }

  dimension: operating_system {
    group_label: "Device"
    description: "The operating system of the device."
    type: string
    sql: ${device}.operating_system ;;
  }

  dimension: operating_system_version {
    group_label: "Device"
    description: "The OS version."
    type: string
    sql: ${device}.operating_system_version ;;
  }

  dimension: time_zone_offset_seconds {
    group_label: "Device"
    description: "The offset from GMT in seconds."
    type: number
    sql: ${device}.time_zone_offset_seconds ;;
  }

  dimension: vendor_id {
    group_label: "Device"
    description: "IDFV (present only if IDFA is not collected)."
    type: string
    sql: ${device}.vendor_id ;;
  }

  #### end device

  dimension: event_bundle_sequence_id {
    description: "The sequential ID of the bundle in which these events were uploaded."
    hidden: yes
    type: number
    sql: ${TABLE}.event_bundle_sequence_id ;;
  }

  dimension_group: event {
    type: time
    timeframes: [date, week, day_of_week, month, year]
    sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d\d\d\d\d'))) ;;
  }

  dimension_group: _event {
    label: "Event"
    timeframes: [raw,time,hour,minute]
    type: time
    sql: TIMESTAMP_MICROS(${TABLE}.event_timestamp) ;;
  }

  dimension: event_dimensions {
    hidden: yes
    sql: ${TABLE}.event_dimensions ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: event_params {
    hidden: yes
    sql: ${TABLE}.event_params ;;
  }

  dimension: event_previous_timestamp {
    hidden: yes
    type: number
    sql: ${TABLE}.event_previous_timestamp ;;
  }

  dimension: event_server_timestamp_offset {
    hidden: yes
    type: number
    sql: ${TABLE}.event_server_timestamp_offset ;;
  }

  dimension: event_value_in_usd {
    type: number
    sql: ${TABLE}.event_value_in_usd ;;
  }

  ### geo dimensions

  dimension: geo {
    hidden: yes
    sql: ${TABLE}.geo ;;
  }

  dimension: city {
    group_label: "User Location"
    description: "The city from which events were reported, based on IP address."
    type: string
    sql: ${geo}.city ;;
  }

  dimension: continent {
    group_label: "User Location"
    description: "The continent from which events were reported, based on IP address."
    type: string
    sql: ${geo}.continent ;;
    drill_fields: [sub_continent,country]
  }

  dimension: country {
    group_label: "User Location"
    description: "The country from which events were reported, based on IP address."
    type: string
    map_layer_name: countries
    sql: ${geo}.country ;;
  }

  dimension: country_tier_android {
    type: string
    case: {
      when: {
        sql: ${geo}.country IN ('Australia','Canada') ;;
        label: "T1A"
      }
      when: {
        sql: ${geo}.country IN ('Germany','New Zealand','Norway','Switzerland', 'United Kingdom') ;;
        label: "T1B"
      }
      when: {
        sql: ${geo}.country IN ('Austria','Belgium','Denmark','Finland','Netherlands','Singapore','Sweden') ;;
        label: "T2"
      }
      when: {
        sql: ${geo}.country IN ('Japan') ;;
        label: "JP"
      }
      when: {
        sql: ${geo}.country IN ('South Korea') ;;
        label: "KR"
      }
      when: {
        sql: ${geo}.country IN ('Taiwan') ;;
        label: "TW"
      }
      when: {
        sql: ${geo}.country IN ('Hong Kong') ;;
        label: "HK"
      }
      # when: {
      #   sql: ${geo}.country IN ('Brazil','Chile','Czechia','Finland','Greece','Iceland','India','Indonesia','Ireland','Israel','Italy','Kuwait','Luxemburg','North Macedonia','Philippines','Poland','Portugal','Qatar','Russia','South Africa','Spain','Thailand','Turkey','Ukraine','United Arab Emirates','Vietnam') ;;
      #   label: "T3"
      # }
      when: {
        sql: ${geo}.country IN ('United States') ;;
        label: "US"
      }
      # when: {
      #   sql: ${geo}.country NOT IN ('Australia','Canada','Germany','New Zealand','Norway','Switzerland', 'United Kingdom'
      #             ,'Austria','Belgium','Denmark','Finland','Netherlands','Singapore','Sweden','Japan','South Korea','Taiwan','Hong Kong','United States'
      #             ) ;;
      #   label: "World Wide minus above"
      # }
      else: "World Wide minus above"
    }
  }

  dimension: country_tier_ios {
    type: string
    case: {
      when: {
        sql: ${geo}.country IN ('Switzerland','Canada','Germany') ;;
        label: "T1A"
      }
      when: {
        sql: ${geo}.country IN ('Australia','New Zealand','Norway', 'United Kingdom') ;;
        label: "T1B"
      }
      when: {
        sql: ${geo}.country IN ('Austria','Sweden') ;;
        label: "T2A"
      }
      when: {
        sql: ${geo}.country IN('Belgium','Denmark','France','Netherlands','Singapore') ;;
        label: "T2B"
      }
      when: {
        sql: ${geo}.country IN ('Japan') ;;
        label: "JP"
      }
      when: {
        sql: ${geo}.country IN ('South Korea') ;;
        label: "KR"
      }
      when: {
        sql: ${geo}.country IN ('Taiwan') ;;
        label: "TW"
      }
      when: {
        sql: ${geo}.country IN ('Hong Kong') ;;
        label: "HK"
      }
      when: {
        sql: ${geo}.country IN ('United States') ;;
        label: "US"
      }
      # when: {
      #   sql: ${geo}.country NOT IN ('United States','Switzerland'
      #   ,'Canada','Germany','Australia','New Zealand','Norway', 'United Kingdom'
      #   ,'Austria','Sweden','Belgium','Denmark','France','Netherlands','Singapore'
      #   ,'Japan','South Korea','Taiwan','Hong Kong','United States'
      #   ) ;;
      #   label: "World Wide minus above"
      # }
      else: "World Wide minus above"
    }
  }

  dimension: metro {
    group_label: "User Location"
    description: "The metro from which events were reported, based on IP address."
    type: string
    sql: ${geo}.metro ;;
  }

  dimension: region {
    group_label: "User Location"
    description: "The region from which events were reported, based on IP address."
    type: string
    sql: ${geo}.region ;;
  }

  dimension: sub_continent {
    group_label: "User Location"
    description: "The subcontinent from which events were reported, based on IP address."
    type: string
    sql: ${geo}.sub_continent ;;
  }

  ### end geo dimensions

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: stream_id {
    hidden: yes
    type: string
    sql: ${TABLE}.stream_id ;;
  }

  dimension: traffic_source {
    hidden: yes
    sql: ${TABLE}.traffic_source ;;
  }

  dimension_group: user_first_touch {
    description: "The time at which the user first opened the app."
    timeframes: [raw,time,hour,minute,date, week, day_of_week, month, year]
    type: time
    sql: TIMESTAMP_MICROS(${TABLE}.user_first_touch_timestamp) ;;
  }

  dimension: user_id {
    description: "The user ID set via the setUserId API."
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_properties {
    hidden: yes
    sql: ${TABLE}.user_properties ;;
  }

  ### user ltv dimensions

  dimension: user_ltv {
    hidden: yes
    sql: ${TABLE}.user_ltv ;;
  }

  dimension: currency {
    group_label: "User LTV"
    description: "The Lifetime Value (currency) of the user. This field is not populated in intraday tables."
    type: string
    sql: ${user_ltv}.currency ;;
  }

  dimension: revenue {
    group_label: "User LTV"
    description: "The Lifetime Value (revenue) of the user. This field is not populated in intraday tables."
    type: number
    sql: ${user_ltv}.revenue ;;
  }

  ### end user ltv dimensions


  dimension: user_pseudo_id {
    description: "The pseudonymous id (e.g., app instance ID) for the user."
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
    # primary_key: yes
  }

  dimension: firebase_user_id {
    description: "either user_id or user_pseudo_id"
    sql: COALESCE(${user_pseudo_id},${user_id}) ;;
    primary_key: yes
  }

  measure: number_of_users {
    type: count_distinct
    sql: ${firebase_user_id} ;;
  }

  measure: number_of_events {
    type: count
    # sql_distinct_key: ${user_pseudo_id} ;;
    # drill_fields: [event_name]
  }


# Retention

  dimension_group: current {
    description: "the time right now"
    type: time
    sql: CURRENT_TIMESTAMP() ;;
  }

  dimension: days_since_user_signup {
    type: number
    description: "Days since first seen (from today)"
    sql:  DATE_DIFF(${current_date}, ${user_first_touch_date}, DAY);;
  }

  dimension: retention_day {
    group_label: "Retention"
    description: "Days since first seen (from event date)"
    type:  number
    sql:  DATE_DIFF(${event_date}, ${user_first_touch_date}, DAY);;
  }

  #D0
  measure: d0_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 0[incl 0]"
    type: count_distinct sql: ${firebase_user_id} ;;
    filters: {
      field: retention_day
      value: "0"
    }
    drill_fields: [country,d0_retained_users]
  }

  measure: d0_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 0 days"
    type: count_distinct
    sql: ${firebase_user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">=0"
    }
  }

  measure: d0_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 0 days) that came back to play on day 1"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d0_retained_users}/${d0_eligible_users};;
    drill_fields: [country,d0_retention_rate]
  }

  # D1

  measure: d1_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 1"
    type: count_distinct sql: ${firebase_user_id} ;;
    filters: {
      field: retention_day
      value: "1"
    }
    drill_fields: [country,d1_retained_users]
  }

  measure: d1_eligible_users {
    # hidden: yes
    group_label: "Retention"
    description: "Number of players older than 0 days"
    type: count_distinct
    sql: ${firebase_user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">0"
    }
  }

  measure: d1_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 0 days) that came back to play on day 1"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d1_retained_users}/ NULLIF(${d1_eligible_users},0);;
    drill_fields: [country,d1_retention_rate]
  }

  # D7

  measure: d7_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 7"
    type: count_distinct sql: ${firebase_user_id} ;;
    filters: {
      field: retention_day
      value: "7"
    }
    drill_fields: [country,d7_retained_users]
  }

  measure: d7_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 7 days"
    type: count_distinct
    sql: ${firebase_user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">7"
    }
    drill_fields: [country,d7_eligible_users]
  }

  measure: d7_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 7 days) that came back to play on day 7"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d7_retained_users}/ NULLIF(${d7_eligible_users},0);;
    drill_fields: [country,d7_retention_rate]
  }

  # D14

  measure: d14_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 14"
    type: count_distinct sql: ${firebase_user_id} ;;
    filters: {
      field: retention_day
      value: "14"
    }
    drill_fields: [country,d14_retained_users]
  }

  measure: d14_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 14 days"
    type: count_distinct
    sql: ${firebase_user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">14"
    }
    drill_fields: [country,d14_eligible_users]
  }

  measure: d14_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 14 days) that came back to play on day 14"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d14_retained_users}/ NULLIF(${d14_eligible_users},0);;
    drill_fields: [country,d14_retention_rate]
  }

  # D30

  measure: d30_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 30"
    type: count_distinct sql: ${firebase_user_id} ;;
    filters: {
      field: retention_day
      value: "30"
    }
    drill_fields: [country,d30_retained_users]
  }

  measure: d30_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 30 days"
    type: count_distinct
    sql: ${firebase_user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">30"
    }
    drill_fields: [country,d30_eligible_users]
  }

  measure: d30_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 30 days) that came back to play on day 30"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d30_retained_users}/ NULLIF(${d30_eligible_users},0);;
    drill_fields: [country,d30_retention_rate]
  }

}

view: events__user_properties__value {

  dimension: double_value {
    required_fields: [events__user_properties.key]
    type: number
    sql: ${TABLE}.double_value ;;
  }

  dimension: float_value {
    required_fields: [events__user_properties.key]
    type: number
    sql: ${TABLE}.float_value ;;
  }

  dimension: int_value {
    required_fields: [events__user_properties.key]
    type: number
    sql: ${TABLE}.int_value ;;
  }

  dimension: set_timestamp_micros {
    required_fields: [events__user_properties.key]
    type: number
    sql: ${TABLE}.set_timestamp_micros ;;
  }

  dimension: string_value {
    required_fields: [events__user_properties.key]
    type: string
    sql: ${TABLE}.string_value ;;
  }

  dimension: type{
    required_fields: [events__user_properties.key]
    sql: CASE
        WHEN ${string_value} is not null then 'string'
        WHEN COALESCE(${int_value},${float_value},${double_value}) is not null then 'number'
        ELSE 'string'
        END;;
  }
}

view: events__user_properties {
  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: events__traffic_source {
  dimension: medium {
    description: "Name of the medium (paid search, organic search, email, etc.) that first acquired the user. This field is not populated in intraday tables."
    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: name {
    description: "Name of the marketing campaign that first acquired the user. This field is not populated in intraday tables."
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: source {
    description: "Name of the network that first acquired the user. This field is not populated in intraday tables."
    type: string
    sql: ${TABLE}.source ;;
  }
}

view: events__event_params__value {

  dimension: double_value {
    required_fields: [events__event_params.key]
    type: number
    sql: ${TABLE}.double_value ;;
  }

  dimension: float_value {
    required_fields: [events__event_params.key]
    type: number
    sql: ${TABLE}.float_value ;;
  }

  dimension: int_value {
    required_fields: [events__event_params.key]
    type: number
    sql: ${TABLE}.int_value ;;
  }

  dimension: string_value {
    required_fields: [events__event_params.key]
    type: string
    sql: ${TABLE}.string_value ;;
  }

  dimension: type{
    required_fields: [events__event_params.key]
    sql: CASE
        WHEN ${string_value} is not null then 'string'
        WHEN COALESCE(${int_value},${float_value},${double_value}) is not null then 'number'
        ELSE 'string'
        END;;
  }
}


# dimension:total_revenue{
#   type: number
#   sql:${TABLE}.value.double_value;;
# }

# dimension: double_value2 {
#   required_fields: [events__event_params.key]
#   type: number
#   sql: ${events__event_params__value}.double_value ;;
# }

view: events__event_params {
  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}


view: events__event_dimensions {
  dimension: hostname {
    type: string
    sql: ${TABLE}.hostname ;;
  }
}

view: events__device__web_info {
  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: browser_version {
    type: string
    sql: ${TABLE}.browser_version ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}.hostname ;;
  }

  #Attribution part

  # dimension: site_id {
  #   type: string
  #   sql: ${TABLE}.site_id ;;
  # }

  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }

  # dimension: source_campaign_id {
  #   type: string
  #   sql: ${TABLE}.source_campaign_id ;;
  # }

  dimension: campaign_name  {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: network_name {
    type: string
    sql: ${TABLE}.network_name ;;
  }







}
