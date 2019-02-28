view: ad_engagements {
  sql_table_name: tenjin_BigQuery.ad_engagements ;;

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  dimension: app_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.app_id ;;
  }

  dimension: attributable {
    type: number
    sql: ${TABLE}.attributable ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
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

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: limit_ad_tracking {
    type: string
    sql: ${TABLE}.limit_ad_tracking ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: remote_click_id {
    type: string
    sql: ${TABLE}.remote_click_id ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  dimension: user_agent {
    type: string
    sql: ${TABLE}.user_agent ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [apps.name, apps.id, campaigns.name, campaigns.id]
  }
}
