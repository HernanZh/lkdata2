view: daily_ad_revenue {
  sql_table_name: tenjin.daily_ad_revenue ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # dimension: banner_clicks {
  #   type: number
  #   sql: ${TABLE}.banner_clicks ;;
  # }

  # dimension: banner_conversions {
  #   type: number
  #   sql: ${TABLE}.banner_conversions ;;
  # }

  # dimension: banner_impressions {
  #   type: number
  #   sql: ${TABLE}.banner_impressions ;;
  # }

  # dimension: banner_revenue {
  #   type: number
  #   sql: ${TABLE}.banner_revenue ;;
  # }

  # dimension: clicks {
  #   type: number
  #   sql: ${TABLE}.clicks ;;
  # }

  # dimension: conversions {
  #   type: number
  #   sql: ${TABLE}.conversions ;;
  # }

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
    # datatype: date
    sql: ${TABLE}.updated_at ;;
  }

  # dimension: impressions {
  #   type: number
  #   sql: ${TABLE}.impressions ;;
  # }

  # dimension: interstitial_clicks {
  #   type: number
  #   sql: ${TABLE}.interstitial_clicks ;;
  # }

  # dimension: interstitial_conversions {
  #   type: number
  #   sql: ${TABLE}.interstitial_conversions ;;
  # }

  # dimension: interstitial_impressions {
  #   type: number
  #   sql: ${TABLE}.interstitial_impressions ;;
  # }

  # dimension: interstitial_revenue {
  #   type: number
  #   sql: ${TABLE}.interstitial_revenue ;;
  # }

  # dimension: native_clicks {
  #   type: number
  #   sql: ${TABLE}.native_clicks ;;
  # }

  # dimension: native_conversions {
  #   type: number
  #   sql: ${TABLE}.native_conversions ;;
  # }

  # dimension: native_impressions {
  #   type: number
  #   sql: ${TABLE}.native_impressions ;;
  # }

  # dimension: native_revenue {
  #   type: number
  #   sql: ${TABLE}.native_revenue ;;
  # }

  # dimension: offerwall_clicks {
  #   type: number
  #   sql: ${TABLE}.offerwall_clicks ;;
  # }

  # dimension: offerwall_conversions {
  #   type: number
  #   sql: ${TABLE}.offerwall_conversions ;;
  # }

  # dimension: offerwall_impressions {
  #   type: number
  #   sql: ${TABLE}.offerwall_impressions ;;
  # }

  # dimension: offerwall_revenue {
  #   type: number
  #   sql: ${TABLE}.offerwall_revenue ;;
  # }

  # dimension: other_clicks {
  #   type: number
  #   sql: ${TABLE}.other_clicks ;;
  # }

  # dimension: other_conversions {
  #   type: number
  #   sql: ${TABLE}.other_conversions ;;
  # }

  # dimension: other_impressions {
  #   type: number
  #   sql: ${TABLE}.other_impressions ;;
  # }

  # dimension: other_revenue {
  #   type: number
  #   sql: ${TABLE}.other_revenue ;;
  # }

  dimension: publisher_app_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.publisher_app_id ;;
  }

  # dimension: revenue {
  #   type: number
  #   sql: ${TABLE}.revenue ;;
  # }

  # dimension_group: updated {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.updated_at ;;
  # }

  # dimension: video_clicks {
  #   type: number
  #   sql: ${TABLE}.video_clicks ;;
  # }

  # dimension: video_conversions {
  #   type: number
  #   sql: ${TABLE}.video_conversions ;;
  # }

  # dimension: video_impressions {
  #   type: number
  #   sql: ${TABLE}.video_impressions ;;
  # }

  # dimension: video_revenue {
  #   type: number
  #   sql: ${TABLE}.video_revenue ;;
  # }

  measure: count {
    type: count
    drill_fields: [id, publisher_apps.id, publisher_apps.name]
  }

  measure: Banner_clicks {
    type: sum
    sql: ${TABLE}.banner_clicks ;;
  }

  measure: Banner_conversions {
    type: sum
    sql: ${TABLE}.banner_conversions ;;
  }

  measure: Banner_impressions {
    type: sum
    sql: ${TABLE}.banner_impressions ;;
  }

  measure: Banner_revenue {
    type: sum
    sql: ${TABLE}.banner_revenue / 100 ;;
    value_format: "$#,##0.00"
  }

  measure: Clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: Conversions {
    type: sum
    sql: ${TABLE}.conversions ;;
  }

  measure: Impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: Interstitial_clicks {
    type: sum
    sql: ${TABLE}.interstitial_clicks ;;
  }

  measure: Interstitial_conversions {
    type: sum
    sql: ${TABLE}.interstitial_conversions ;;
  }

  measure: Interstitial_impressions {
    type: sum
    sql: ${TABLE}.interstitial_impressions ;;
  }

  measure: Interstitial_revenue {
    type: sum
    sql: ${TABLE}.interstitial_revenue / 100 ;;
    value_format: "$#,##0.00"
  }

  measure: Native_clicks {
    type: sum
    sql: ${TABLE}.native_clicks ;;
  }

  measure: Native_conversions {
    type: sum
    sql: ${TABLE}.native_conversions ;;
  }

  measure: Native_impressions {
    type: sum
    sql: ${TABLE}.native_impressions ;;
  }

  measure: Native_revenue {
    type: sum
    sql: ${TABLE}.native_revenue / 100 ;;
    value_format: "$#,##0.00"
  }

  measure: Offerwall_clicks {
    type: sum
    sql: ${TABLE}.offerwall_clicks ;;
  }

  measure: Offerwall_conversions {
    type: sum
    sql: ${TABLE}.offerwall_conversions ;;
  }

  measure: Offerwall_impressions {
    type: sum
    sql: ${TABLE}.offerwall_impressions ;;
  }

  measure: Offerwall_revenue {
    type: sum
    sql: ${TABLE}.offerwall_revenue / 100 ;;
    value_format: "$#,##0.00"
  }

  measure: Other_clicks {
    type: sum
    sql: ${TABLE}.other_clicks ;;
  }

  measure: Other_conversions {
    type: sum
    sql: ${TABLE}.other_conversions ;;
  }

  measure: Other_impressions {
    type: sum
    sql: ${TABLE}.other_impressions ;;
  }

  measure: Other_revenue {
    type: sum
    sql: ${TABLE}.other_revenue / 100 ;;
    value_format: "$#,##0.00"
  }
  measure: Revenue {
    type: sum
    sql: ${TABLE}.revenue / 100 ;;
    value_format: "$#,##0.00"
  }

  measure: Video_clicks {
    type: sum
    sql: ${TABLE}.video_clicks ;;
  }

  measure: Video_conversions {
    type: sum
    sql: ${TABLE}.video_conversions ;;
  }

  measure: Video_impressions {
    type: sum
    sql: ${TABLE}.video_impressions ;;
  }

  measure: Video_revenue {
    type: sum
    sql: ${TABLE}.video_revenue / 100 ;;
    value_format: "$#,##0.00"
  }

  measure: Ad_Revenue {
    type: sum
    sql: cast(${TABLE}.revenue as float) / 100 ;;
    value_format: "$#,##0.00"
  }

}
