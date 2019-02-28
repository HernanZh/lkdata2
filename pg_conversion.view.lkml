view: pg_conversion {
  sql_table_name: tenjin_BigQuery.pg_conversion ;;

  dimension: condefault {
    type: number
    sql: ${TABLE}.condefault ;;
  }

  dimension: conforencoding {
    type: number
    sql: ${TABLE}.conforencoding ;;
  }

  dimension: conname {
    type: string
    sql: ${TABLE}.conname ;;
  }

  dimension: connamespace {
    type: number
    sql: ${TABLE}.connamespace ;;
  }

  dimension: conowner {
    type: number
    sql: ${TABLE}.conowner ;;
  }

  dimension: conproc {
    type: string
    sql: ${TABLE}.conproc ;;
  }

  dimension: contoencoding {
    type: number
    sql: ${TABLE}.contoencoding ;;
  }

  measure: count {
    type: count
    drill_fields: [conname]
  }
}
