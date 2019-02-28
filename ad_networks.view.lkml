view: ad_networks {
  sql_table_name: tenjin_BigQuery.ad_networks ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
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
      bucket_campaign_info.count,
      campaign_buckets.count,
      campaigns.count,
      publisher_apps.count,
      reporting_cohort_metrics.count,
      reporting_metrics.count
    ]
  }
}
