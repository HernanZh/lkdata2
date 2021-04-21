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
    # primary_key: yes
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

  measure: D1_revenue {
    type: sum
    value_format: "$#.##"
    sql: CASE WHEN conversion_value= 0 THEN 0.0*${conversion_value_count}
              WHEN conversion_value= 1 THEN 0.001097131904040271*${conversion_value_count}
              WHEN conversion_value= 2 THEN 0.0026448641442398976*${conversion_value_count}
              WHEN conversion_value= 3 THEN 0.004899533248677693*${conversion_value_count}
              WHEN conversion_value= 4 THEN 0.007861139217353657*${conversion_value_count}
              WHEN conversion_value= 5 THEN 0.01152968205026779*${conversion_value_count}
              WHEN conversion_value= 6 THEN 0.015905161747420092*${conversion_value_count}
              WHEN conversion_value= 7 THEN 0.020987578308810564*${conversion_value_count}
              WHEN conversion_value= 8 THEN 0.0267769317344392*${conversion_value_count}
              WHEN conversion_value= 9 THEN 0.03327322202430601*${conversion_value_count}
              WHEN conversion_value= 10 THEN 0.040476449178410985*${conversion_value_count}
              WHEN conversion_value= 11 THEN 0.04838661319675413*${conversion_value_count}
              WHEN conversion_value= 12 THEN 0.05700371407933545*${conversion_value_count}
              WHEN conversion_value= 13 THEN 0.06632775182615494*${conversion_value_count}
              WHEN conversion_value= 14 THEN 0.07635872643721259*${conversion_value_count}
              WHEN conversion_value= 15 THEN 0.0870966379125084*${conversion_value_count}
              WHEN conversion_value= 16 THEN 0.0985414862520424*${conversion_value_count}
              WHEN conversion_value= 17 THEN 0.11069327145581456*${conversion_value_count}
              WHEN conversion_value= 18 THEN 0.1235519935238249*${conversion_value_count}
              WHEN conversion_value= 19 THEN 0.13711765245607338*${conversion_value_count}
              WHEN conversion_value= 20 THEN 0.15139024825256003*${conversion_value_count}
              WHEN conversion_value= 21 THEN 0.1663697809132849*${conversion_value_count}
              WHEN conversion_value= 22 THEN 0.18205625043824789*${conversion_value_count}
              WHEN conversion_value= 23 THEN 0.19844965682744906*${conversion_value_count}
              WHEN conversion_value= 24 THEN 0.21555000008088843*${conversion_value_count}
              WHEN conversion_value= 25 THEN 0.23335728019856594*${conversion_value_count}
              WHEN conversion_value= 26 THEN 0.25187149718048163*${conversion_value_count}
              WHEN conversion_value= 27 THEN 0.2710926510266355*${conversion_value_count}
              WHEN conversion_value= 28 THEN 0.2910207417370275*${conversion_value_count}
              WHEN conversion_value= 29 THEN 0.31165576931165767*${conversion_value_count}
              WHEN conversion_value= 30 THEN 0.332997733750526*${conversion_value_count}
              WHEN conversion_value= 31 THEN 0.35504663505363254*${conversion_value_count}
              WHEN conversion_value= 32 THEN 0.37780247322097726*${conversion_value_count}
              WHEN conversion_value= 33 THEN 0.4012652482525601*${conversion_value_count}
              WHEN conversion_value= 34 THEN 0.4254349601483811*${conversion_value_count}
              WHEN conversion_value= 35 THEN 0.4503116089084403*${conversion_value_count}
              WHEN conversion_value= 36 THEN 0.47589519453273765*${conversion_value_count}
              WHEN conversion_value= 37 THEN 0.5021857170212732*${conversion_value_count}
              WHEN conversion_value= 38 THEN 0.5291831763740469*${conversion_value_count}
              WHEN conversion_value= 39 THEN 0.5568875725910588*${conversion_value_count}
              WHEN conversion_value= 40 THEN 0.5852989056723088*${conversion_value_count}
              WHEN conversion_value= 41 THEN 0.614417175617797*${conversion_value_count}
              WHEN conversion_value= 42 THEN 0.6442423824275234*${conversion_value_count}
              WHEN conversion_value= 43 THEN 0.6747745261014879*${conversion_value_count}
              WHEN conversion_value= 44 THEN 0.7060136066396907*${conversion_value_count}
              WHEN conversion_value= 45 THEN 0.7379596240421316*${conversion_value_count}
              WHEN conversion_value= 46 THEN 0.7706125783088106*${conversion_value_count}
              WHEN conversion_value= 47 THEN 0.8039724694397278*${conversion_value_count}
              WHEN conversion_value= 48 THEN 0.8380392974348834*${conversion_value_count}
              WHEN conversion_value= 49 THEN 0.8728130622942769*${conversion_value_count}
              WHEN conversion_value= 50 THEN 0.9082937640179087*${conversion_value_count}
              WHEN conversion_value= 51 THEN 0.9444814026057786*${conversion_value_count}
              WHEN conversion_value= 52 THEN 0.9813759780578866*${conversion_value_count}
              WHEN conversion_value= 53 THEN 1.2866419429098765*${conversion_value_count}
              WHEN conversion_value= 54 THEN 1.9245974401476542*${conversion_value_count}
              WHEN conversion_value= 55 THEN 2.6918961602214813*${conversion_value_count}
              WHEN conversion_value= 56 THEN 3.588538103131358*${conversion_value_count}
              WHEN conversion_value= 57 THEN 4.614523268877283*${conversion_value_count}
              WHEN conversion_value= 58 THEN 5.769851657459258*${conversion_value_count}
              WHEN conversion_value= 59 THEN 7.054523268877283*${conversion_value_count}
              WHEN conversion_value= 60 THEN 8.468538103131356*${conversion_value_count}
              WHEN conversion_value= 61 THEN 10.01189616022148*${conversion_value_count}
              WHEN conversion_value= 62 THEN 11.684597440147655*${conversion_value_count}
              WHEN conversion_value = 63 THEN 13.486641942909877*${conversion_value_count}
            ELSE NULL END ;;
  }
}
