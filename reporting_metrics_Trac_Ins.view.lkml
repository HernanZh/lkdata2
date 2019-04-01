# If necessary, uncomment the line below to include explore_source.

# include: "lk_datawarehouse2.model.lkml"

view: reporting_metrics_Trac_Ins {
  derived_table: {
    explore_source: reporting_metrics {
      column: ad_network_id {}
      column: app_id {}
      column: campaign_id {}
      column: country {}
      column: daily_active_users {}
      column: date_date {}
      column: iap_revenue {}
      column: platform {}
      column: publisher_ad_revenue {}
      column: reported_clicks {}
      column: reported_impressions {}
      column: reported_installs {}
      column: reported_spend {}
      column: sessions {}
      column: site_id {}
      column: tracked_clicks {}
      column: tracked_impressions {}
      column: tracked_installs {}
      filters: {
        field: reporting_metrics.tracked_installs
        value: ">0"
      }
    }
  }
  dimension: ad_network_id {
    type: number
  }
  dimension: app_id {}
  dimension: campaign_id {}
  dimension: country {}
  dimension: daily_active_users {
    type: number
  }
  dimension: date_date {
    type: date
  }
  dimension: iap_revenue {
    type: number
  }
  dimension: platform {}
  dimension: publisher_ad_revenue {}
  dimension: reported_clicks {}
  dimension: reported_impressions {}
  dimension: reported_installs {}
  dimension: reported_spend {}
  dimension: sessions {
    type: number
  }
  dimension: site_id {}
  dimension: tracked_clicks {
    type: number
  }
  dimension: tracked_impressions {
    type: number
  }
  dimension: tracked_installs {
    type: number
  }

  measure: track_installs {
    type: sum
    sql: ${TABLE}.tracked_installs ;;
  }

  measure: rep_spend {
    type: number
    sql: SUM(cast(${TABLE}.reported_spend as float64))/100 ;;
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

  measure: DAU{
    type: number
    sql: (sum(${TABLE}.daily_active_users)/${distinct_dates}) ;;
  }

  measure: distinct_dates {
    type: count_distinct
    sql: ${date_date} ;;
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

  measure: IAP_ARPDAU {
    type: number
    sql: CASE WHEN ${DAU} <> 0 and ${Iap_revenue} <> 0
          THEN ${avg_iap_revenue}/${DAU}
          ELSE 0
          END;;
    value_format: "$#,##0.00"
  }

  measure: Iap_revenue {
    type: number
    sql: sum(case when (${TABLE}.date_date) >= '2019-02-01'
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

  measure: rep_installs {
    type: number
    sql: SUM(cast(${TABLE}.reported_installs as FLOAT64)) ;;
  }
}
