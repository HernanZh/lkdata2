view: sk_ad_network_metrics_new{
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

  measure: SK_installs {
    type: sum
    sql: ${TABLE}.conversion_value_count ;;
  }

  measure: D1_revenue {
    type: sum
    value_format: "$#.##"
    sql: CASE WHEN conversion_value=0 THEN 0*${conversion_value_count}
WHEN conversion_value=1 THEN 0.005*${conversion_value_count}
WHEN conversion_value=2 THEN 0.01*${conversion_value_count}
WHEN conversion_value=3 THEN 0.015*${conversion_value_count}
WHEN conversion_value=4 THEN 0.02*${conversion_value_count}
WHEN conversion_value=5 THEN 0.025*${conversion_value_count}
WHEN conversion_value=6 THEN 0.03*${conversion_value_count}
WHEN conversion_value=7 THEN 0.035*${conversion_value_count}
WHEN conversion_value=8 THEN 0.04*${conversion_value_count}
WHEN conversion_value=9 THEN 0.045*${conversion_value_count}
WHEN conversion_value=10 THEN 0.05*${conversion_value_count}
WHEN conversion_value=11 THEN 0.055*${conversion_value_count}
WHEN conversion_value=12 THEN 0.06*${conversion_value_count}
WHEN conversion_value=13 THEN 0.065*${conversion_value_count}
WHEN conversion_value=14 THEN 0.07*${conversion_value_count}
WHEN conversion_value=15 THEN 0.075*${conversion_value_count}
WHEN conversion_value=16 THEN 0.08*${conversion_value_count}
WHEN conversion_value=17 THEN 0.085*${conversion_value_count}
WHEN conversion_value=18 THEN 0.09*${conversion_value_count}
WHEN conversion_value=19 THEN 0.095*${conversion_value_count}
WHEN conversion_value=20 THEN 0.1*${conversion_value_count}
WHEN conversion_value=21 THEN 0.11*${conversion_value_count}
WHEN conversion_value=22 THEN 0.12*${conversion_value_count}
WHEN conversion_value=23 THEN 0.13*${conversion_value_count}
WHEN conversion_value=24 THEN 0.14*${conversion_value_count}
WHEN conversion_value=25 THEN 0.15*${conversion_value_count}
WHEN conversion_value=26 THEN 0.16*${conversion_value_count}
WHEN conversion_value=27 THEN 0.17*${conversion_value_count}
WHEN conversion_value=28 THEN 0.18*${conversion_value_count}
WHEN conversion_value=29 THEN 0.19*${conversion_value_count}
WHEN conversion_value=30 THEN 0.2*${conversion_value_count}
WHEN conversion_value=31 THEN 0.21*${conversion_value_count}
WHEN conversion_value=32 THEN 0.22*${conversion_value_count}
WHEN conversion_value=33 THEN 0.23*${conversion_value_count}
WHEN conversion_value=34 THEN 0.24*${conversion_value_count}
WHEN conversion_value=35 THEN 0.25*${conversion_value_count}
WHEN conversion_value=36 THEN 0.26*${conversion_value_count}
WHEN conversion_value=37 THEN 0.27*${conversion_value_count}
WHEN conversion_value=38 THEN 0.28*${conversion_value_count}
WHEN conversion_value=39 THEN 0.29*${conversion_value_count}
WHEN conversion_value=40 THEN 0.3*${conversion_value_count}
WHEN conversion_value=41 THEN 0.32*${conversion_value_count}
WHEN conversion_value=42 THEN 0.34*${conversion_value_count}
WHEN conversion_value=43 THEN 0.36*${conversion_value_count}
WHEN conversion_value=44 THEN 0.38*${conversion_value_count}
WHEN conversion_value=45 THEN 0.4*${conversion_value_count}
WHEN conversion_value=46 THEN 0.42*${conversion_value_count}
WHEN conversion_value=47 THEN 0.44*${conversion_value_count}
WHEN conversion_value=48 THEN 0.46*${conversion_value_count}
WHEN conversion_value=49 THEN 0.48*${conversion_value_count}
WHEN conversion_value=50 THEN 0.5*${conversion_value_count}
WHEN conversion_value=51 THEN 0.55*${conversion_value_count}
WHEN conversion_value=52 THEN 0.6*${conversion_value_count}
WHEN conversion_value=53 THEN 0.65*${conversion_value_count}
WHEN conversion_value=54 THEN 0.7*${conversion_value_count}
WHEN conversion_value=55 THEN 0.75*${conversion_value_count}
WHEN conversion_value=56 THEN 0.8*${conversion_value_count}
WHEN conversion_value=57 THEN 0.85*${conversion_value_count}
WHEN conversion_value=58 THEN 0.9*${conversion_value_count}
WHEN conversion_value=59 THEN 1*${conversion_value_count}
WHEN conversion_value=60 THEN 1.25*${conversion_value_count}
WHEN conversion_value=61 THEN 1.5*${conversion_value_count}
WHEN conversion_value=62 THEN 2*${conversion_value_count}
WHEN conversion_value=63 THEN 9999*${conversion_value_count}
ELSE NULL END ;;
  }
}
