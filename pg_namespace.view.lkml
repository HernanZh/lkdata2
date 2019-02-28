view: pg_namespace {
  sql_table_name: tenjin_BigQuery.pg_namespace ;;

  dimension: nspacl {
    type: string
    sql: ${TABLE}.nspacl ;;
  }

  dimension: nspname {
    type: string
    sql: ${TABLE}.nspname ;;
  }

  dimension: nspowner {
    type: number
    sql: ${TABLE}.nspowner ;;
  }

  measure: count {
    type: count
    drill_fields: [nspname]
  }
}
