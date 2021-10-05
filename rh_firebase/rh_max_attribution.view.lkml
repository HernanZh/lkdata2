view: rh_max_attribution {
  sql_table_name: `lk-datawarehouse-2.rh_firebase.firebase_max_attribution`
    ;;

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }

  dimension_group: event {
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
    sql: ${TABLE}.event_date ;;
  }

  dimension: experiment {
    type: string
    sql: ${TABLE}.experiment ;;
  }

  dimension: experiment_variant {
    type: string
    sql: ${TABLE}.experimentVariant ;;
  }

  dimension: idfa {
    type: string
    sql: ${TABLE}.idfa ;;
  }

  dimension: network_name {
    type: string
    sql: ${TABLE}.network_name ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: retention_day {
    type: number
    sql: ${TABLE}.retention_day ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#.###"
  }

  measure: DAU {
    type: count_distinct
    sql: ${idfa} ;;
  }

  dimension: source_campaign_id {
    type: string
    sql: ${TABLE}.source_campaign_id ;;
  }

  measure: count {
    type: count
    drill_fields: [creative_name, campaign_name, network_name]
  }
}
