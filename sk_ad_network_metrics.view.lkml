 view: sk_ad_network_metrics{
  sql_table_name: tenjin_dv.sk_ad_network_metrics;;

  dimension: ad_network_id {
    type: number
    sql: ${TABLE}.ad_network_id ;;
  }

   dimension: app_id{
    type: string
    sql: ${TABLE}.app_id;;
   }

   dimension: conversion_value{
    type: number
    sql: ${TABLE}.conversion_value;;
    }

   dimension: conversion_value_count{
    type: number
    sql: ${TABLE}.conversion_value_count;;
   }

   dimension_group: date {
    type: time
    description: "%E4Y-%m-%d"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date;;

   }

   dimension: fidelity_type{
    type: string
    sql: ${TABLE}.fidelity_type;;

   }

   dimension_group: loaded{
    type: time
    description: "bq-datetime"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.loaded_at;;
   }

   dimension: redownload_count{
    type: number
    sql: ${TABLE}.redownload_count;;
   }

   dimension: sk_ad_network_id{
    type: string
    # hidden: yes
    sql: ${TABLE}.sk_ad_network_id;;
   }

   dimension: sk_app_id{
    type: number
    primary_key: yes
    sql: ${TABLE}.sk_app_id;;
   }

   dimension: sk_campaign_id{
    type: number
    sql: ${TABLE}.sk_campaign_id;;
   }

   dimension: sk_source_app_id{
    type: number
    sql: ${TABLE}.sk_source_app_id;;
   }
   measure: count{
    type: count
    drill_fields: [sk_ad_networks.id]
   }

  measure: conversion_value_revenue {
    type: sum
    sql: CASE WHEN events.value= 0 THEN 0.0
              WHEN events.value= 1 THEN 0.001097131904040271
              WHEN events.value= 2 THEN 0.0026448641442398976
              WHEN events.value= 3 THEN 0.004899533248677693
              WHEN events.value= 4 THEN 0.007861139217353657
              WHEN events.value= 5 THEN 0.01152968205026779
              WHEN events.value= 6 THEN 0.015905161747420092
              WHEN events.value= 7 THEN 0.020987578308810564
              WHEN events.value= 8 THEN 0.0267769317344392
              WHEN events.value= 9 THEN 0.03327322202430601
              WHEN events.value= 10 THEN 0.040476449178410985
              WHEN events.value= 11 THEN 0.04838661319675413
              WHEN events.value= 12 THEN 0.05700371407933545
              WHEN events.value= 13 THEN 0.06632775182615494
              WHEN events.value= 14 THEN 0.07635872643721259
              WHEN events.value= 15 THEN 0.0870966379125084
              WHEN events.value= 16 THEN 0.0985414862520424
              WHEN events.value= 17 THEN 0.11069327145581456
              WHEN events.value= 18 THEN 0.1235519935238249
              WHEN events.value= 19 THEN 0.13711765245607338
              WHEN events.value= 20 THEN 0.15139024825256003
              WHEN events.value= 21 THEN 0.1663697809132849
              WHEN events.value= 22 THEN 0.18205625043824789
              WHEN events.value= 23 THEN 0.19844965682744906
              WHEN events.value= 24 THEN 0.21555000008088843
              WHEN events.value= 25 THEN 0.23335728019856594
              WHEN events.value= 26 THEN 0.25187149718048163
              WHEN events.value= 27 THEN 0.2710926510266355
              WHEN events.value= 28 THEN 0.2910207417370275
              WHEN events.value= 29 THEN 0.31165576931165767
              WHEN events.value= 30 THEN 0.332997733750526
              WHEN events.value= 31 THEN 0.35504663505363254
              WHEN events.value= 32 THEN 0.37780247322097726
              WHEN events.value= 33 THEN 0.4012652482525601
              WHEN events.value= 34 THEN 0.4254349601483811
              WHEN events.value= 35 THEN 0.4503116089084403
              WHEN events.value= 36 THEN 0.47589519453273765
              WHEN events.value= 37 THEN 0.5021857170212732
              WHEN events.value= 38 THEN 0.5291831763740469
              WHEN events.value= 39 THEN 0.5568875725910588
              WHEN events.value= 40 THEN 0.5852989056723088
              WHEN events.value= 41 THEN 0.614417175617797
              WHEN events.value= 42 THEN 0.6442423824275234
              WHEN events.value= 43 THEN 0.6747745261014879
              WHEN events.value= 44 THEN 0.7060136066396907
              WHEN events.value= 45 THEN 0.7379596240421316
              WHEN events.value= 46 THEN 0.7706125783088106
              WHEN events.value= 47 THEN 0.8039724694397278
              WHEN events.value= 48 THEN 0.8380392974348834
              WHEN events.value= 49 THEN 0.8728130622942769
              WHEN events.value= 50 THEN 0.9082937640179087
              WHEN events.value= 51 THEN 0.9444814026057786
              WHEN events.value= 52 THEN 0.9813759780578866
              WHEN events.value= 53 THEN 1.2866419429098765
              WHEN events.value= 54 THEN 1.9245974401476542
              WHEN events.value= 55 THEN 2.6918961602214813
              WHEN events.value= 56 THEN 3.588538103131358
              WHEN events.value= 57 THEN 4.614523268877283
              WHEN events.value= 58 THEN 5.769851657459258
              WHEN events.value= 59 THEN 7.054523268877283
              WHEN events.value= 60 THEN 8.468538103131356
              WHEN events.value= 61 THEN 10.01189616022148
              WHEN events.value= 62 THEN 11.684597440147655
              WHEN events.value = 63 THEN 13.486641942909877
            ELSE NULL END) ;;
  }
}
