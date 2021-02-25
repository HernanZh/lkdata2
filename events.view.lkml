view: events {
  sql_table_name: tenjin_dv.events ;;

  dimension_group: acquired {
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
    sql: ${TABLE}.acquired_at ;;
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  parameter: id_type {
    allowed_value: {
      label: "Yes"
      value: "brand"
    }
    allowed_value: {
      label: "No"
      value: "category"
    }
  }

  dimension: Formatted_or_unformatted {
    type: string
    sql: case when {% parameter id_type %} = 'brand' then ${formated_advertising_id} else ${advertising_id} end;;
  }

  measure: count_events {
    type: number
    sql: count(${event});;
  }

  dimension: formated_advertising_id {
    type: string
    sql: UPPER(SUBSTRING(${advertising_id}, 1, 8) || '-' || SUBSTRING(${advertising_id}, 9, 4) || '-' ||
          SUBSTRING(${advertising_id}, 13, 4) || '-' || SUBSTRING(${advertising_id}, 17, 4) || '-' ||
          SUBSTRING(${advertising_id}, 21, 12));;
  }
  measure: Events_90_percentile {
    type: percentile
    percentile: 90
    sql: count(${event}) ;;
  }

  dimension: app_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.app_id ;;
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.app_version ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }


  dimension: country_bucket {
    type: string
    case: {
      when: {
        sql: ${TABLE}.country IN ('AU','CA','DE','NZ','NO','CH', 'GB') ;;
        label: "T1"
      }
      when: {
        sql: ${TABLE}.country IN ('HK','JP','KR','TW') ;;
        label: "T1_LOC"
      }
      when: {
        sql: ${TABLE}.country IN ('AT','BE','DK','FR','NL','SG','SE') ;;
        label: "T2"
      }
      when: {
        sql: ${TABLE}.country IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN') ;;
        label: "T3"
      }
      when: {
        sql: ${TABLE}.country IN ('US') ;;
        label: "US"
      }
      when: {
        sql: ${TABLE}.country IN ('CN') ;;
        label: "CN"
      }
      else: "Unknown"
    }
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: developer_device_id {
    type: string
    sql: ${TABLE}.developer_device_id ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: limit_ad_tracking {
    type: yesno
    sql: ${TABLE}.limit_ad_tracking ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: purchase_state {
    type: number
    sql: ${TABLE}.purchase_state ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  dimension: source_campaign_id {
    type: string
    sql: ${TABLE}.source_campaign_id ;;
  }

  dimension: source_uuid {
    type: string
    sql: ${TABLE}.source_uuid ;;
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  dimension: uuid {
    primary_key: yes
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: [creative_name, apps.id, apps.name]
  }

  dimension_group: days_since_install {
    type: duration
    intervals: [day]
    sql_start: ${acquired_date::datetime} ;;
    sql_end: ${created_date::datetime} ;;
  }

  measure: dau {
    type: count_distinct
    sql: coalesce(${advertising_id},${developer_device_id}) ;;
  }

  measure: D_new_user {
    type: count_distinct
    sql: ${TABLE}.developer_device_id ;;
  }

  measure: trial_user {
    type: count_distinct
    sql: coalesce(${advertising_id}) ;;
  }

  measure: iap_revenue {
    type:  sum
    sql: case when ${purchase_state} = 3 then ${TABLE}.revenue / 100 else 0 end;;
  }

  measure: app_id_dis_count {
    type:  count_distinct
    sql: ${app_id};;
  }

  measure: publisher_ad_revenue {
    type: sum
    sql: cast(publisher_ad_revenue as float)/100 ;;
  }

  measure:  distinct_users{
    type: count_distinct
    sql: ${Formatted_or_unformatted} ;;
  }

  measure:  count_rows{
    type: count_distinct
    sql: case when ${Formatted_or_unformatted} then 1 else 0 end ;;
  }

  measure: purchase_count {
    type: sum
    sql: case when ${event_type} = 'purchase' then 1 else 0 end  ;;
  }

#   Does not work because primary key is not unique
#   measure: arppu {
#     type: average_distinct
#     sql_distinct_key: coalesce(${advertising_id},${developer_device_id}) ;;
#     sql: ${revenue} ;;
#   }

  measure: paying_users {
    type: count_distinct
    sql: case when ${event_type} = 'purchase' and ${purchase_state} = 3 then coalesce(${advertising_id},${developer_device_id}) else null end ;;
  }

  measure: total_value {
    type: sum
    sql: ${TABLE}.value ;;
  }

  measure: conversion_value {
    type: max
    sql: ${TABLE}.value;;
  }
  measure: conversion_value_max {
    type: max
    sql: CASE WHEN ${TABLE}.value= 0 THEN 0.0
      WHEN ${TABLE}.value= 1 THEN 0.0026448641442398976
      WHEN ${TABLE}.value= 2 THEN 0.004899533248677693
      WHEN ${TABLE}.value= 3 THEN 0.007861139217353657
      WHEN ${TABLE}.value= 4 THEN 0.01152968205026779
      WHEN ${TABLE}.value= 5 THEN 0.015905161747420092
      WHEN ${TABLE}.value= 6 THEN 0.020987578308810564
      WHEN ${TABLE}.value= 7 THEN 0.0267769317344392
      WHEN ${TABLE}.value= 8 THEN 0.03327322202430601
      WHEN ${TABLE}.value= 9 THEN 0.040476449178410985
      WHEN ${TABLE}.value= 10 THEN 0.04838661319675413
      WHEN ${TABLE}.value= 11 THEN 0.05700371407933545
      WHEN ${TABLE}.value= 12 THEN 0.06632775182615494
      WHEN ${TABLE}.value= 13 THEN 0.07635872643721259
      WHEN ${TABLE}.value= 14 THEN 0.0870966379125084
      WHEN ${TABLE}.value= 15 THEN 0.0985414862520424
      WHEN ${TABLE}.value= 16 THEN 0.11069327145581456
      WHEN ${TABLE}.value= 17 THEN 0.1235519935238249
      WHEN ${TABLE}.value= 18 THEN 0.13711765245607338
      WHEN ${TABLE}.value= 19 THEN 0.15139024825256003
      WHEN ${TABLE}.value= 20 THEN 0.1663697809132849
      WHEN ${TABLE}.value= 21 THEN 0.18205625043824789
      WHEN ${TABLE}.value= 22 THEN 0.19844965682744906
      WHEN ${TABLE}.value= 23 THEN 0.21555000008088843
      WHEN ${TABLE}.value= 24 THEN 0.23335728019856594
      WHEN ${TABLE}.value= 25 THEN 0.25187149718048163
      WHEN ${TABLE}.value= 26 THEN 0.2710926510266355
      WHEN ${TABLE}.value= 27 THEN 0.2910207417370275
      WHEN ${TABLE}.value= 28 THEN 0.31165576931165767
      WHEN ${TABLE}.value= 29 THEN 0.332997733750526
      WHEN ${TABLE}.value= 30 THEN 0.35504663505363254
      WHEN ${TABLE}.value= 31 THEN 0.37780247322097726
      WHEN ${TABLE}.value= 32 THEN 0.4012652482525601
      WHEN ${TABLE}.value= 33 THEN 0.4254349601483811
      WHEN ${TABLE}.value= 34 THEN 0.4503116089084403
      WHEN ${TABLE}.value= 35 THEN 0.47589519453273765
      WHEN ${TABLE}.value= 36 THEN 0.5021857170212732
      WHEN ${TABLE}.value= 37 THEN 0.5291831763740469
      WHEN ${TABLE}.value= 38 THEN 0.5568875725910588
      WHEN ${TABLE}.value= 39 THEN 0.5852989056723088
      WHEN ${TABLE}.value= 40 THEN 0.614417175617797
      WHEN ${TABLE}.value= 41 THEN 0.6442423824275234
      WHEN ${TABLE}.value= 42 THEN 0.6747745261014879
      WHEN ${TABLE}.value= 43 THEN 0.7060136066396907
      WHEN ${TABLE}.value= 44 THEN 0.7379596240421316
      WHEN ${TABLE}.value= 45 THEN 0.7706125783088106
      WHEN ${TABLE}.value= 46 THEN 0.8039724694397278
      WHEN ${TABLE}.value= 47 THEN 0.8380392974348834
      WHEN ${TABLE}.value= 48 THEN 0.8728130622942769
      WHEN ${TABLE}.value= 49 THEN 0.9082937640179087
      WHEN ${TABLE}.value= 50 THEN 0.9444814026057786
      WHEN ${TABLE}.value= 51 THEN 0.9813759780578866
      WHEN ${TABLE}.value= 52 THEN 1.2866419429098765
      WHEN ${TABLE}.value= 53 THEN 1.9245974401476542
      WHEN ${TABLE}.value= 54 THEN 2.6918961602214813
      WHEN ${TABLE}.value= 55 THEN 3.588538103131358
      WHEN ${TABLE}.value= 56 THEN 4.614523268877283
      WHEN ${TABLE}.value= 57 THEN 5.769851657459258
      WHEN ${TABLE}.value= 58 THEN 7.054523268877283
      WHEN ${TABLE}.value= 59 THEN 8.468538103131356
      WHEN ${TABLE}.value= 60 THEN 10.01189616022148
      WHEN ${TABLE}.value= 61 THEN 11.684597440147655
      WHEN ${TABLE}.value = 62 THEN 13.486641942909877
      ELSE NULL END;;
  }

}
