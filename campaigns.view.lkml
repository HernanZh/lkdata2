view: campaigns {
  #sql_table_name: tenjin_BigQuery.campaigns ;;
  sql_table_name: tenjin_dv.campaigns;;


  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

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

  dimension: campaign_bucket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_bucket_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: remote_campaign_id {
    type: string
    sql: ${TABLE}.remote_campaign_id ;;
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

  measure: oldest_date {
    type: date
    sql:  MIN(${updated_date});;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      campaign_buckets.name,
      campaign_buckets.id,
      apps.name,
      apps.id,
      ad_networks.name,
      ad_networks.id,
      ad_engagements.count,
      campaigns_targeting_tags.count,
      cohort_behavior.count,
      daily_behavior.count,
      daily_country_spend.count,
      daily_spend.count,
      reporting_cohort_metrics.count,
      reporting_metrics.count
    ]
  }
}
