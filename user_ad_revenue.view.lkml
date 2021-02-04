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

  measure: install_date {
    type: date
    sql: min(${date_created_raw}) ;;
    convert_tz: no
  }

  # dimension_group: updated {
  #   type: time
  #   timeframes: [time, date, week, month, raw]
  #   sql: ${TABLE}.updated_at ;;
  # }

  measure: impressions {
    type: sum
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

  dimension: revenue_bucket{
    case: {
      when: {
        sql: ${TABLE}.revenue <= 0.2;;
        label: "< $0.2"
      }
      when: {
        sql: ${TABLE}.revenue> 0.2 AND ${TABLE}.revenue <= 0.5;;
        label: "Between $0.2 and $0.5"
      }
      when: {
        sql: ${TABLE}.revenue > 0.5 AND ${TABLE}.revenue <= 1;;
        label: "Between $0.5 and $1.0"
      }
      when: {
        sql: ${TABLE}.revenue > 1;;
        label: "> $1.0"
      }
      else:"Unknown"
    }
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

  measure: arpdau {
    type: number
    sql: SUM(${TABLE}.revenue) / COUNT(DISTINCT ${TABLE}.user_id) ;;
    value_format: "$#,##0.0000"
  }
}
