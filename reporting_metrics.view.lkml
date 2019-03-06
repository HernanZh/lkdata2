view: reporting_metrics {
  sql_table_name: tenjin_BigQuery.reporting_metrics ;;

  dimension: ad_network_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ad_network_id ;;
  }

  dimension: app_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.app_id ;;
  }

  dimension: Key {
    type: string
    # hidden: yes
    sql: ${date_date}||${site_id}||${ad_network_id}||${app_id}||${campaign_id}||${country} ;;
  }

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: daily_active_users {
    type: number
    sql: ${TABLE}.daily_active_users ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: iap_revenue {
    type: number
    sql: ${TABLE}.iap_revenue ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: publisher_ad_revenue {
    type: string
    sql: ${TABLE}.publisher_ad_revenue;;
  }

  dimension: reported_clicks {
    type: string
    sql: ${TABLE}.reported_clicks ;;
  }

  dimension: reported_impressions {
    type: string
    sql: ${TABLE}.reported_impressions ;;
  }

  dimension: reported_installs {
    type: string
    sql: ${TABLE}.reported_installs ;;
  }

  dimension: reported_spend {
    type: string
    sql: ${TABLE}.reported_spend ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  dimension: tracked_clicks {
    type: number
    sql: ${TABLE}.tracked_clicks ;;
  }

  dimension: tracked_impressions {
    type: number
    sql: ${TABLE}.tracked_impressions ;;
  }

  dimension: tracked_installs {
    type: number
    sql: ${TABLE}.tracked_installs ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: distinct_dates {
    type: count_distinct
    sql: ${date_date} ;;
  }

  measure: track_installs {
    type: sum
    sql: ${TABLE}.tracked_installs ;;
  }

  measure: rep_installs {
    type: number
    sql: SUM(cast(${TABLE}.reported_installs as INT64)) ;;
  }

  measure: rep_impressions {
    type: number
    sql: sum(cast(${TABLE}.reported_impressions as INT64)) ;;
  }

  measure: track_impressions {
    type: sum
    sql: ${TABLE}.tracked_impressions ;;
  }

  measure: rep_clicks {
    type: number
    sql: sum(cast(${TABLE}.reported_clicks as INT64)) ;;
  }

  measure: CTR {
    type: number
    sql: (${rep_clicks}/${rep_impressions})*100 ;;
    value_format: "0.00\%"
  }

  measure: rep_spend {
    type: number
    sql: SUM(cast(${TABLE}.reported_spend as float64))/100 ;;
    value_format: "$#,##0.00"
  }

  measure: DAU{
    type: number
    sql: (sum(${TABLE}.daily_active_users)/${distinct_dates}) ;;
  }

  measure: ad_revenue {
    type: number
    sql: sum(cast(${TABLE}.publisher_ad_revenue as float64))/100 ;;
    value_format: "$#,##0.00"
  }

  measure: avg_ad_revenue {
    type: number
    sql: (${ad_revenue}/${distinct_dates});;
    value_format: "$#,##0.00"
  }

  measure: Ad_ARPDAU {
    type: number
    sql: CASE WHEN ${DAU} <> 0 and ${ad_revenue} <> 0
    THEN ${avg_ad_revenue}/${DAU}
    ELSE 0
    END;;
    value_format: "$#,##0.00"
  }

  measure: Iap_revenue {
    type: number
    sql: sum(case when (${TABLE}.date) >= '2019-02-01'
          then ${TABLE}.iap_revenue
          else 0
          end)/100;;
    value_format: "$#,##0.00"
  }

measure: avg_iap_revenue {
    type: number
    sql: (${Iap_revenue}/${distinct_dates});;
    value_format: "$#,##0.00"
  }

  measure: IAP_ARPDAU {
    type: number
    sql: CASE WHEN ${DAU} <> 0 and ${Iap_revenue} <> 0
    THEN ${avg_iap_revenue}/${DAU}
    ELSE 0
    END;;
    value_format: "$#,##0.00"
  }

  measure: Total_ARPDAU {
    type: number
    sql: ${Ad_ARPDAU}+${IAP_ARPDAU};;
    value_format: "$#,##0.00"
  }

  measure: CPI {
    type: number
    sql: case when ${rep_spend} <> 0 and ${rep_installs} <> 0
    then ${rep_spend}/${rep_installs}
    else 0
    end;;
    value_format: "$#,##0.00"
  }

  measure: Total_revenue{
    type: number
    sql: CASE
              WHEN ${ad_revenue} is not Null and ${Iap_revenue} is not Null
              THEN
              ${ad_revenue} + ${Iap_revenue}
              WHEN ${ad_revenue} is null and ${Iap_revenue} is not Null
              THEN
              ${Iap_revenue}
              WHEN ${ad_revenue} is not Null and ${Iap_revenue} is null
              THEN
              ${ad_revenue}
              ELSE 0
          END;;
    value_format: "$#,##0.00"
  }

  measure: ROI {
    type: number
    sql: (${Total_revenue}-${rep_spend})/${rep_spend};;
    value_format: "0.00\%"
  }

  measure: ROAS {
    type: number
    sql: ${ad_revenue}/${rep_spend};;
    value_format: "0.00\%"
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      ad_networks.name,
      ad_networks.id,
      apps.name,
      apps.id,
      campaigns.name,
      campaigns.id
    ]
  }
}
