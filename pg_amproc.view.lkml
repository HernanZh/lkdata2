view: pg_amproc {
  sql_table_name: tenjin_BigQuery.pg_amproc ;;

  dimension: amopclaid {
    type: number
    value_format_name: id
    sql: ${TABLE}.amopclaid ;;
  }

  dimension: amproc {
    type: string
    sql: ${TABLE}.amproc ;;
  }

  dimension: amprocnum {
    type: number
    sql: ${TABLE}.amprocnum ;;
  }

  dimension: amprocsubtype {
    type: number
    sql: ${TABLE}.amprocsubtype ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
