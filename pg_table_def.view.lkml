view: pg_table_def {
  sql_table_name: tenjin_BigQuery.pg_table_def ;;

  dimension: column {
    type: string
    sql: ${TABLE}.column ;;
  }

  dimension: distkey {
    type: string
    sql: ${TABLE}.distkey ;;
  }

  dimension: encoding {
    type: string
    sql: ${TABLE}.encoding ;;
  }

  dimension: notnull {
    type: number
    sql: ${TABLE}.notnull ;;
  }

  dimension: schemaname {
    type: string
    sql: ${TABLE}.schemaname ;;
  }

  dimension: sortkey {
    type: number
    sql: ${TABLE}.sortkey ;;
  }

  dimension: tablename {
    type: string
    sql: ${TABLE}.tablename ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [schemaname, tablename]
  }
}
