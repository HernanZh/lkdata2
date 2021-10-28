view: krun_ecpm {
  sql_table_name: `lk-datawarehouse-2.krun_firebase.krun_eCPM`
    ;;

  dimension: ad_network {
    type: string
    sql: ${TABLE}.ad_network ;;
  }

  dimension: ad_unit {
    type: string
    sql: ${TABLE}.ad_unit ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  measure: ecpm {
    type: average
    sql: ${TABLE}.eCPM ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#.##"
  }

  dimension_group: event {
    type: time
    timeframes: [date, week, day_of_week, month, year]
    sql: TIMESTAMP(PARSE_DATE('%Y%m%d', REGEXP_EXTRACT(suffix,r'\d\d\d\d\d\d\d\d'))) ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
