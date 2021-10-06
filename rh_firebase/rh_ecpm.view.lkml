view: rh_ecpm {
  sql_table_name: `lk-datawarehouse-2.rh_firebase.rh_eCPM`
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
  }

  dimension_group: utc {
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
    sql: ${TABLE}.UTC_date ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
