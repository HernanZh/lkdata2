view: reporting_metrics {
  #sql_table_name: tenjin_BigQuery.reporting_metrics ;;
  sql_table_name: tenjin_dv.reporting_metrics ;;

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
    primary_key: yes
    type: string
    # hidden: yes
    sql: concat(cast(${date_date} AS STRING),${site_id},cast(${ad_network_id} AS STRING),${app_id},${campaign_id},${country}) ;;
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

  measure: Date_Count{
    type: count_distinct
    sql: ${date_date} ;;
  }

  measure: Daily_Active_Users{
    type: sum
    sql: ${TABLE}.daily_active_users ;;
  }

  measure: D_Active_Users{
    type: number
    sql: ${Daily_Active_Users}/${Date_Count} ;;
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

  dimension_group: loaded_at {
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
    sql: ${TABLE}.loaded_at ;;
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
    type: number
    sql: SUM(${TABLE}.tracked_installs) ;;
  }

  measure: rep_installs {
    type: number
    sql: SUM(cast(${TABLE}.reported_installs as FLOAT64)) ;;
  }

  measure: rep_impressions {
    type: number
    sql: sum(cast(${TABLE}.reported_impressions as FLOAT64)) ;;
    value_format: "0"
  }

  measure: track_impressions {
    type: sum
    sql: ${TABLE}.tracked_impressions ;;
  }

  measure: rep_clicks {
    type: number
    sql: sum(cast(${TABLE}.reported_clicks as FLOAT64)) ;;
  }

  measure: CTR {
    type: number
    sql: CASE WHEN ${rep_clicks} <> 0 and ${rep_impressions} <> 0
    THEN (${rep_clicks}/${rep_impressions})*100
    ELSE 0
    END ;;
    value_format: "0.00\%"
  }

  measure: IPM {
    type: number
    sql: CASE WHEN ${rep_installs} <> 0 and ${rep_impressions} <> 0
    THEN (${rep_installs}/${rep_impressions})*1000
    ELSE 0
    END ;;
    value_format: "0"
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
    sql: ((${Total_revenue}-${rep_spend})/${rep_spend});;
    value_format: "0.00%"
  }

  measure: ROAS {
    type: number
    sql: ${ad_revenue}/${rep_spend};;
    value_format: "0.00\%"
  }

  measure: org_installs {
    type: sum
    filters: {
      field: campaigns.name
      value: "Organic"
    }
    sql: ${TABLE}.tracked_installs;;
  }

#   measure: key_count {
#     type: count
#   }
#
#   measure: key_distinct_count {
#     type: count_distinct
#     sql: ${Key} ;;
#   }

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
