view: ltv_for_14_30_60_and_90_days {
  derived_table: {
    sql: SELECT reporting_cohort_metrics.install_date AS DATE,
       reporting_cohort_metrics.ad_network_id,
       reporting_cohort_metrics.app_id,
       reporting_cohort_metrics.campaign_id,
       reporting_cohort_metrics.site_id,
       reporting_cohort_metrics.country,
       SUM(CASE WHEN days_since_install <= 1 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d1_total_LTV,
       SUM(CASE WHEN days_since_install <= 2 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d2_total_LTV,
       SUM(CASE WHEN days_since_install <= 3 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d3_total_LTV,
       SUM(CASE WHEN days_since_install <= 7 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d7_total_LTV,
       SUM(CASE WHEN days_since_install <= 14 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d14_total_LTV,
       SUM(CASE WHEN days_since_install <= 21 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d21_total_LTV,
       SUM(CASE WHEN days_since_install <= 30 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d30_total_LTV,
       SUM(CASE WHEN days_since_install <= 60 THEN (cast(publisher_ad_revenue as float64) + Iap_revenue) / 100.0 ELSE 0 END) AS d60_total_LTV,
       SUM(CASE WHEN days_since_install <= 0 THEN daily_active_users ELSE 0 END) AS d1_retained_users
FROM reporting_cohort_metrics
  LEFT JOIN apps ON apps.id = reporting_cohort_metrics.app_id
  LEFT JOIN bucket_campaign_info ON bucket_campaign_info.id = reporting_cohort_metrics.campaign_id
  LEFT JOIN ad_networks ON ad_networks.id = bucket_campaign_info.ad_network_id
GROUP BY 1,
         2,
         3,
         4,
         5,
         6
order BY 1,
         2,
         3,
         4,
         5,
         6
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

  dimension: Key {
    type: string
    primary_key: yes
    # hidden: yes
    sql: ${date}||${site_id}||${ad_network_id}||${app_id}||${campaign_id}||${country} ;;
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

  dimension: d1_total_ltv {
    type: number
    sql: ${TABLE}.d1_total_ltv ;;
  }

  dimension: d2_total_ltv {
    type: number
    sql: ${TABLE}.d2_total_ltv ;;
  }

  dimension: d3_total_ltv {
    type: number
    sql: ${TABLE}.d3_total_ltv ;;
  }

  dimension: d7_total_ltv {
    type: number
    sql: ${TABLE}.d7_total_ltv ;;
  }

  dimension: d14_total_ltv {
    type: number
    sql: ${TABLE}.d14_total_ltv ;;
  }

  dimension: d21_total_ltv {
    type: number
    sql: ${TABLE}.d21_total_ltv ;;
  }

  dimension: d30_total_ltv {
    type: number
    sql: ${TABLE}.d30_total_ltv ;;
  }

  dimension: d60_total_ltv {
    type: number
    sql: ${TABLE}.d60_total_ltv ;;
  }

  dimension: d1_retained_users {
    type: number
    sql: ${TABLE}.d1_retained_users ;;
  }

  measure: day_1_ltv {
    type: sum
    sql: ${TABLE}.d1_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: day_2_ltv {
    type: sum
    sql: ${TABLE}.d2_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: day_3_ltv {
    type: sum
    sql: ${TABLE}.d3_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: day_7_ltv {
    type: sum
    sql: ${TABLE}.d7_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: day_14_ltv {
    type: sum
    sql: ${TABLE}.d14_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: day_21_ltv {
    type: sum
    sql: ${TABLE}.d21_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: day_30_ltv {
    type: sum
    sql: ${TABLE}.d30_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: day_60_ltv {
    type: sum
    sql: ${TABLE}.d60_total_ltv ;;
    value_format: "$#,##0.00"
  }

  measure: first_day_users {
    type: sum
    sql: ${TABLE}.d1_retained_users ;;
  }

  measure: LTV_per_Users_7_Days {
    type: number
    sql: ${day_7_ltv}/${first_day_users} ;;
    value_format: "$#,##0.00"
  }

  measure: LTV_per_Users_14_Days {
    type: number
    sql: ${day_14_ltv}/${first_day_users} ;;
    value_format: "$#,##0.00"
  }

  measure: LTV_per_Users_30_Days {
    type: number
    sql: ${day_30_ltv}/${first_day_users} ;;
    value_format: "$#,##0.00"
  }

  set: detail {
    fields: [
      date,
      ad_network_id,
      app_id,
      campaign_id,
      site_id,
      country,
      d1_total_ltv,
      d7_total_ltv,
      d14_total_ltv,
      d30_total_ltv,
      d1_retained_users,
    ]
  }
}
