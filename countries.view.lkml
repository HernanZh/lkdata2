view: countries {
  sql_table_name: tenjin.countries;;
  #sql_table_name: tenjin_BigQuery.countries ;;

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
