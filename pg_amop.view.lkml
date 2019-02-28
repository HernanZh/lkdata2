view: pg_amop {
  sql_table_name: tenjin_BigQuery.pg_amop ;;

  dimension: amopclaid {
    type: number
    value_format_name: id
    sql: ${TABLE}.amopclaid ;;
  }

  dimension: amopopr {
    type: number
    sql: ${TABLE}.amopopr ;;
  }

  dimension: amopreqcheck {
    type: string
    sql: ${TABLE}.amopreqcheck ;;
  }

  dimension: amopstrategy {
    type: number
    sql: ${TABLE}.amopstrategy ;;
  }

  dimension: amopsubtype {
    type: number
    sql: ${TABLE}.amopsubtype ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
