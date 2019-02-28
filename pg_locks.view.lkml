view: pg_locks {
  sql_table_name: tenjin_BigQuery.pg_locks ;;

  dimension: database {
    type: number
    sql: ${TABLE}.database ;;
  }

  dimension: granted {
    type: number
    sql: ${TABLE}.granted ;;
  }

  dimension: mode {
    type: string
    sql: ${TABLE}.mode ;;
  }

  dimension: pid {
    type: number
    value_format_name: id
    sql: ${TABLE}.pid ;;
  }

  dimension: relation {
    type: number
    sql: ${TABLE}.relation ;;
  }

  dimension: transaction {
    type: number
    sql: ${TABLE}.transaction ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
