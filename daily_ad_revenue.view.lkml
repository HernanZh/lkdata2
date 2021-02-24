view: daily_ad_revenue {
  #sql_table_name: tenjin_BigQuery.daily_ad_revenue ;;
  sql_table_name: tenjin_dv.daily_ad_revenue ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: banner_clicks {
    type: number
    sql: ${TABLE}.banner_clicks ;;
  }

  dimension: banner_conversions {
    type: number
    sql: ${TABLE}.banner_conversions ;;
  }

  dimension: banner_impressions {
    type: number
    sql: ${TABLE}.banner_impressions ;;
  }

  dimension: banner_revenue {
    type: number
    sql: ${TABLE}.banner_revenue ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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
    sql: ${TABLE}.updated_at ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: interstitial_clicks {
    type: number
    sql: ${TABLE}.interstitial_clicks ;;
  }

  dimension: interstitial_conversions {
    type: number
    sql: ${TABLE}.interstitial_conversions ;;
  }

  dimension: interstitial_impressions {
    type: number
    sql: ${TABLE}.interstitial_impressions ;;
  }

  dimension: interstitial_revenue {
    type: number
    sql: ${TABLE}.interstitial_revenue ;;
  }

  dimension: native_clicks {
    type: number
    sql: ${TABLE}.native_clicks ;;
  }

  dimension: native_conversions {
    type: number
    sql: ${TABLE}.native_conversions ;;
  }

  dimension: native_impressions {
    type: number
    sql: ${TABLE}.native_impressions ;;
  }

  dimension: native_revenue {
    type: number
    sql: ${TABLE}.native_revenue ;;
  }

  dimension: offerwall_clicks {
    type: number
    sql: ${TABLE}.offerwall_clicks ;;
  }

  dimension: offerwall_conversions {
    type: number
    sql: ${TABLE}.offerwall_conversions ;;
  }

  dimension: offerwall_impressions {
    type: number
    sql: ${TABLE}.offerwall_impressions ;;
  }

  dimension: offerwall_revenue {
    type: number
    sql: ${TABLE}.offerwall_revenue ;;
  }

  dimension: other_clicks {
    type: number
    sql: ${TABLE}.other_clicks ;;
  }

  dimension: other_conversions {
    type: number
    sql: ${TABLE}.other_conversions ;;
  }

  dimension: other_impressions {
    type: number
    sql: ${TABLE}.other_impressions ;;
  }

  dimension: other_revenue {
    type: number
    sql: ${TABLE}.other_revenue ;;
  }

  dimension: publisher_app_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.publisher_app_id ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }

  dimension: video_clicks {
    type: number
    sql: ${TABLE}.video_clicks ;;
  }

  dimension: video_conversions {
    type: number
    sql: ${TABLE}.video_conversions ;;
  }

  dimension: video_impressions {
    type: number
    sql: ${TABLE}.video_impressions ;;
  }

  dimension: video_revenue {
    type: number
    sql: ${TABLE}.video_revenue ;;
  }

  measure: count {
    type: count
    drill_fields: [id, publisher_apps.name, publisher_apps.id]
  }
}
