view: apps {
  #sql_table_name: tenjin_BigQuery.apps ;;
  sql_table_name: tenjin_dv.apps ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: store_id {
    type: string
    sql: ${TABLE}.store_id ;;
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

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      ad_engagements.count,
      bucket_campaign_info.count,
      campaign_buckets.count,
      campaigns.count,
      events.count,
      publisher_apps.count,
      reporting_cohort_metrics.count,
      reporting_metrics.count
    ]
  }
}
