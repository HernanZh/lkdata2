view: pg_highwatermark {
  sql_table_name: tenjin_BigQuery.pg_highwatermark ;;

  dimension: hwm {
    type: number
    sql: ${TABLE}.hwm ;;
  }

  dimension: hwmcolnum {
    type: number
    sql: ${TABLE}.hwmcolnum ;;
  }

  dimension: hwmrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.hwmrelid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
