view: impressions {
  sql_table_name: `lk-datawarehouse-2.gameanalytics.impressions`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: ab {
    type: string
    sql: ${TABLE}.ab ;;
  }

  dimension: ad_network {
    type: string
    sql: ${TABLE}.adNetwork ;;
  }

  dimension: ad_unit {
    type: string
    sql: ${TABLE}.adUnit ;;
  }

  dimension: adgroup_id {
    type: string
    sql: ${TABLE}.adgroup_id ;;
  }

  dimension: adgroup_name {
    type: string
    sql: ${TABLE}.adgroup_name ;;
  }

  dimension: adgroup_priority {
    type: number
    sql: ${TABLE}.adgroup_priority ;;
  }

  dimension: adgroup_type {
    type: string
    sql: ${TABLE}.adgroup_type ;;
  }

  dimension: adunit_format {
    type: string
    sql: ${TABLE}.adunit_format ;;
  }

  dimension: adunit_id {
    type: string
    sql: ${TABLE}.adunit_id ;;
  }

  dimension: adunit_name {
    type: string
    sql: ${TABLE}.adunit_name ;;
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.app_version ;;
  }

  dimension: auction_id {
    type: string
    sql: ${TABLE}.auctionId ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: game_id {
    type: number
    sql: ${TABLE}.game_id ;;
  }

  dimension: idfa {
    type: string
    sql: ${TABLE}.idfa ;;
  }

  dimension: idfv {
    type: string
    sql: ${TABLE}.idfv ;;
  }

  dimension_group: inserted {
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
    sql: ${TABLE}.inserted_at ;;
  }

  dimension: instance_id {
    type: string
    sql: ${TABLE}.instanceId ;;
  }

  dimension: instance_name {
    type: string
    sql: ${TABLE}.instanceName ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetimeRevenue ;;
  }

  dimension: network_name {
    type: string
    sql: ${TABLE}.network_name ;;
  }

  dimension: network_placement_id {
    type: string
    sql: ${TABLE}.network_placement_id ;;
  }

  dimension: placement {
    type: string
    sql: ${TABLE}.placement ;;
  }

  dimension: precision {
    type: string
    sql: ${TABLE}.precision ;;
  }

  dimension: publisher_revenue {
    type: number
    sql: ${TABLE}.publisher_revenue ;;
  }

  dimension: publisher_revenue_usd_cents {
    type: number
    sql: ${TABLE}.publisher_revenue_usd_cents ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, instance_name, adunit_name, network_name, adgroup_name]
  }
}
