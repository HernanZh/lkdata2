view: schema_migrations {
  sql_table_name: tenjin_BigQuery.schema_migrations ;;

  dimension: string_field_0 {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
