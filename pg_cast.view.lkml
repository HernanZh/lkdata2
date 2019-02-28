view: pg_cast {
  sql_table_name: tenjin_BigQuery.pg_cast ;;

  dimension: castcontext {
    type: string
    sql: ${TABLE}.castcontext ;;
  }

  dimension: castfunc {
    type: number
    sql: ${TABLE}.castfunc ;;
  }

  dimension: castsource {
    type: number
    sql: ${TABLE}.castsource ;;
  }

  dimension: casttarget {
    type: number
    sql: ${TABLE}.casttarget ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
