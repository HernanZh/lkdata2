view: pg_resize {
  sql_table_name: tenjin_BigQuery.pg_resize ;;

  dimension: string_field_0 {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
