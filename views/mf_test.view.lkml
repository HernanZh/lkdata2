view: mf_test {
  sql_table_name: `lk-datawarehouse-2.applovin.MF_test`
    ;;

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: days_since_install {
    type: number
    sql: ${TABLE}.days_since_install ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
