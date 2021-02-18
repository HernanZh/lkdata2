view: reporting_cohort_metrics {
  #sql_table_name: tenjin_BigQuery.reporting_cohort_metrics ;;
  sql_table_name: tenjin_dv.reporting_cohort_metrics ;;

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

  dimension: daily_active_users {
    type: number
    sql: ${TABLE}.daily_active_users ;;
  }

  measure: dau {
    type: sum
    sql: ${TABLE}.daily_active_users ;;
  }

  dimension: days_since_install {
    type: number
    sql: ${TABLE}.days_since_install ;;
  }

  dimension_group: event {
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
    sql: ${TABLE}.event_date ;;
  }

  dimension: iap_revenue {
    type: number
    sql: ${TABLE}.iap_revenue ;;
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
    sql: ${TABLE}.install_date ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: publisher_ad_revenue {
    type: string
    sql: ${TABLE}.publisher_ad_revenue ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: Iap_revenue {
    type: number
    sql: sum(${TABLE}.iap_revenue);;
    value_format: "$#,##0.00"
  }

  measure: ad_revenue {
    type: number
    sql: sum(cast(${TABLE}.publisher_ad_revenue as FLOAT64))/100 ;;
  }

  measure: Total_revenue {
    type: number
    sql: (${Iap_revenue}/100+${ad_revenue})/100 ;;
  }

  measure: Total_revenue_dollar {
    type: number
    sql: ${Total_revenue} * 100 ;;
    value_format: "$#,##0.00"
  }

  measure: Total_revenue_per_User {
    type: number
    sql: ${Total_revenue}/${dau} ;;
    value_format: "$#,##0.00"
  }

  measure: ad_revenue_per_User {
    type: number
    sql: ${ad_revenue}/${dau} ;;
    value_format: "$#,##0.00"
  }

  measure: days_installed {
    type: number
    sql: MAX(${TABLE}.days_since_install) + 1 ;;
  }
  measure: Total_revenue_d1 {
    type: number
    label: "Revenue D01"
    sql: SUM(CASE WHEN days_since_install <= 0 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d2 {
    type: number
    label: "Revenue D02"
    sql: SUM(CASE WHEN days_since_install <= 1 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d3 {
    type: number
    label: "Revenue D03"
    sql: SUM(CASE WHEN days_since_install <= 2 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d4 {
    type: number
    label: "Revenue D04"
    sql: SUM(CASE WHEN days_since_install <= 3 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d5 {
    type: number
    label: "Revenue D05"
    sql: SUM(CASE WHEN days_since_install <= 4 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d6 {
    type: number
    label: "Revenue D06"
    sql: SUM(CASE WHEN days_since_install <= 5 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d7 {
    type: number
    label: "Revenue D07"
    sql: SUM(CASE WHEN days_since_install <= 6 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d14 {
    type: number
    label: "Revenue D14"
    sql: SUM(CASE WHEN days_since_install <= 13 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d21 {
    type: number
    label: "Revenue D21"
    sql: SUM(CASE WHEN days_since_install <= 20 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d30 {
    type: number
    label: "Revenue D30"
    sql: SUM(CASE WHEN days_since_install <= 29 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
  }
  measure: Total_revenue_d60 {
    type: number
    label: "Revenue D60"
    sql: SUM(CASE WHEN days_since_install <= 59 THEN (cast(${TABLE}.publisher_ad_revenue as float64) + ${TABLE}.Iap_revenue) / 100.0 ELSE 0 END) ;;
    value_format: "$#,##0.00"
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
