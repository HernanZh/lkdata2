#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines

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
}
