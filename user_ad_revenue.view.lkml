view: user_ad_revenue {
  sql_table_name: tenjin_BigQuery.user_ad_revenue ;;

  dimension: ab_testing {
    type: string
    sql: ${TABLE}.AB_Testing ;;
  }

  dimension: ad_network {
    type: string
    sql: ${TABLE}.ad_network ;;
  }

  dimension: ad_unit {
    type: string
    sql: ${TABLE}.ad_unit ;;
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  dimension: advertising_id_type {
    type: string
    sql: ${TABLE}.advertising_id_type ;;
  }

  dimension: idfa {
    type: string
    sql: ${TABLE}.idfa ;;
  }

  dimension: idfv {
    type: string
    sql: ${TABLE}.idfv ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension_group: date_created {
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
    sql: ${TABLE}.date_created ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: placement {
    type: string
    sql: ${TABLE}.placement ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: revenue_dim {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: limit_ad_tracking {
    type: yesno
    sql: ${TABLE}.advertising_id_type = 'idfv' ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: unique_users {
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0.00"
  }
}
