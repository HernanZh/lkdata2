view: pg_index {
  sql_table_name: tenjin_BigQuery.pg_index ;;

  dimension: indclass {
    type: string
    sql: ${TABLE}.indclass ;;
  }

  dimension: indexprs {
    type: string
    sql: ${TABLE}.indexprs ;;
  }

  dimension: indexrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.indexrelid ;;
  }

  dimension: indisclustered {
    type: string
    sql: ${TABLE}.indisclustered ;;
  }

  dimension: indisprimary {
    type: number
    sql: ${TABLE}.indisprimary ;;
  }

  dimension: indisunique {
    type: number
    sql: ${TABLE}.indisunique ;;
  }

  dimension: indkey {
    type: string
    sql: ${TABLE}.indkey ;;
  }

  dimension: indnatts {
    type: number
    sql: ${TABLE}.indnatts ;;
  }

  dimension: indpred {
    type: string
    sql: ${TABLE}.indpred ;;
  }

  dimension: indrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.indrelid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
