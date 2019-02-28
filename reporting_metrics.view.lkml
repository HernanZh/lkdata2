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
    sql: ${TABLE}.publisher_ad_revenue ;;
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
