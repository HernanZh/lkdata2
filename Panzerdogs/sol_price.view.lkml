view: sol_price {
  sql_table_name: `lk-datawarehouse-2.sol_test_dataset.SOL_price`
    ;;

  measure: close {
    type: sum
    sql: ${TABLE}.close ;;
  }

  dimension: conversion_symbol {
    type: string
    sql: ${TABLE}.conversionSymbol ;;
  }

  dimension: conversion_type {
    type: string
    sql: ${TABLE}.conversionType ;;
  }

  measure: high {
    type: sum
    sql: ${TABLE}.high ;;
  }

  measure: low {
    type: sum
    sql: ${TABLE}.low ;;
  }

  measure: open {
    type: sum
    sql: ${TABLE}.open ;;
  }

  dimension_group: time {
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
    sql: ${TABLE}.time ;;
  }

  measure: volumefrom {
    type: sum
    sql: ${TABLE}.volumefrom ;;
  }

  measure: volumeto {
    type: sum
    sql: ${TABLE}.volumeto ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
