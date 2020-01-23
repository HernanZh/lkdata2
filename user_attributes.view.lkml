view: user_attributes {
  sql_table_name: tenjin_BigQuery.rs_user_attributes ;;

  dimension_group: acquired {
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
    sql: ${TABLE}.acquired_at ;;
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
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

  dimension: developer_device_id {
    type: string
    sql: ${TABLE}.developer_device_id ;;
  }

  dimension_group: last_seen {
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
    sql: ${TABLE}.last_seen ;;
  }

  dimension: limit_ad_tracking {
    type: yesno
    sql: ${TABLE}.limit_ad_tracking ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  measure: count {
    type: count
    drill_fields: [campaigns.name, campaigns.remote_campaign_id]
  }
}
