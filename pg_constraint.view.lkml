view: pg_constraint {
  sql_table_name: tenjin_BigQuery.pg_constraint ;;

  dimension: conbin {
    type: string
    sql: ${TABLE}.conbin ;;
  }

  dimension: condeferrable {
    type: string
    sql: ${TABLE}.condeferrable ;;
  }

  dimension: condeferred {
    type: string
    sql: ${TABLE}.condeferred ;;
  }

  dimension: confdeltype {
    type: string
    sql: ${TABLE}.confdeltype ;;
  }

  dimension: confkey {
    type: string
    sql: ${TABLE}.confkey ;;
  }

  dimension: confmatchtype {
    type: string
    sql: ${TABLE}.confmatchtype ;;
  }

  dimension: confrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.confrelid ;;
  }

  dimension: confupdtype {
    type: string
    sql: ${TABLE}.confupdtype ;;
  }

  dimension: conkey {
    type: string
    sql: ${TABLE}.conkey ;;
  }

  dimension: conname {
    type: string
    sql: ${TABLE}.conname ;;
  }

  dimension: connamespace {
    type: number
    sql: ${TABLE}.connamespace ;;
  }

  dimension: conrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.conrelid ;;
  }

  dimension: consrc {
    type: string
    sql: ${TABLE}.consrc ;;
  }

  dimension: contype {
    type: string
    sql: ${TABLE}.contype ;;
  }

  dimension: contypid {
    type: number
    value_format_name: id
    sql: ${TABLE}.contypid ;;
  }

  measure: count {
    type: count
    drill_fields: [conname]
  }
}
