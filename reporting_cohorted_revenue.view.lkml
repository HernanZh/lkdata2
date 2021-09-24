view: reporting_cohorted_revenue {
  derived_table: {
    sql: SELECT reporting_cohort_metrics.install_date AS DATE,
       reporting_cohort_metrics.ad_network_id,
       reporting_cohort_metrics.app_id,
       reporting_cohort_metrics.campaign_id,
       reporting_cohort_metrics.site_id,
       reporting_cohort_metrics.country,
       reporting_cohort_metrics.platform,
       SUM(CASE WHEN days_since_install <= 0 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d1,
       SUM(CASE WHEN days_since_install <= 1 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d2,
       SUM(CASE WHEN days_since_install <= 2 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d3,
       SUM(CASE WHEN days_since_install <= 3 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d4,
       SUM(CASE WHEN days_since_install <= 4 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d5,
       SUM(CASE WHEN days_since_install <= 5 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d6,
       SUM(CASE WHEN days_since_install <= 6 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d7,
       SUM(CASE WHEN days_since_install <= 13 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d14,
       SUM(CASE WHEN days_since_install <= 20 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d21,
       SUM(CASE WHEN days_since_install <= 29 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d30,
       SUM(CASE WHEN days_since_install <= 59 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d60,
       SUM(CASE WHEN days_since_install <= 89 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS revenue_d90,
       SUM(CASE WHEN days_since_install <= 0 THEN daily_active_users ELSE 0 END) AS tracked_installs
FROM reporting_cohort_metrics
  LEFT JOIN apps ON apps.id = reporting_cohort_metrics.app_id
  -- LEFT JOIN bucket_campaign_info ON bucket_campaign_info.id = reporting_cohort_metrics.campaign_id
  -- LEFT JOIN ad_networks ON ad_networks.id = bucket_campaign_info.ad_network_id
     LEFT JOIN ad_networks ON ad_networks.id = reporting_cohort_metrics.ad_network_id
GROUP BY reporting_cohort_metrics.install_date,
         reporting_cohort_metrics.ad_network_id,
         reporting_cohort_metrics.app_id,
         reporting_cohort_metrics.campaign_id,
         reporting_cohort_metrics.site_id,
         reporting_cohort_metrics.country,
         reporting_cohort_metrics.platform
order BY DATE
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: CAST(${TABLE}.date as TIMESTAMP) ;;
  }

  dimension_group: install {
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
    sql: ${date} ;;
  }

  dimension: ad_network_id {
    type: number
    sql: ${TABLE}.ad_network_id ;;
  }

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  measure: revenue_d1 {
    type: sum
    label: "Revenue D01"
    sql: ${TABLE}.revenue_d1 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d2 {
    type: sum
    label: "Revenue D02"
    sql: ${TABLE}.revenue_d2 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d3 {
    type: sum
    label: "Revenue D03"
    sql: ${TABLE}.revenue_d3 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d4 {
    type: sum
    label: "Revenue D04"
    sql: ${TABLE}.revenue_d4 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d5 {
    type: sum
    label: "Revenue D05"
    sql: ${TABLE}.revenue_d5 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d6 {
    type: sum
    label: "Revenue D06"
    sql: ${TABLE}.revenue_d6 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d7 {
    type: sum
    label: "Revenue D07"
    sql: ${TABLE}.revenue_d7 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d14 {
    type: sum
    label: "Revenue D14"
    sql: ${TABLE}.revenue_d14 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d21 {
    type: sum
    label: "Revenue D21"
    sql: ${TABLE}.revenue_d21 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d30 {
    type: sum
    label: "Revenue D30"
    sql: ${TABLE}.revenue_d30 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d60 {
    type: sum
    label: "Revenue D60"
    sql: ${TABLE}.revenue_d60 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d90 {
    type: sum
    label: "Revenue D90"
    sql: ${TABLE}.revenue_d90 ;;
    value_format: "$#,##0.00"
  }

  measure: tracked_installs {
    type: sum
    sql: ${TABLE}.tracked_installs ;;
  }

  set: detail {
    fields: [
      date,
      ad_network_id,
      app_id,
      campaign_id,
      site_id,
      country,
      revenue_d1,
      revenue_d2,
      revenue_d3,
      revenue_d4,
      revenue_d5,
      revenue_d6,
      revenue_d7,
      revenue_d14,
      revenue_d30,
      revenue_d60,
      revenue_d90,
      tracked_installs,
    ]
  }
}
