view: pg_trigger {
  sql_table_name: tenjin_BigQuery.pg_trigger ;;

  dimension: tgargs {
    type: string
    sql: ${TABLE}.tgargs ;;
  }

  dimension: tgattr {
    type: string
    sql: ${TABLE}.tgattr ;;
  }

  dimension: tgconstrname {
    type: string
    sql: ${TABLE}.tgconstrname ;;
  }

  dimension: tgconstrrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tgconstrrelid ;;
  }

  dimension: tgdeferrable {
    type: string
    sql: ${TABLE}.tgdeferrable ;;
  }

  dimension: tgenabled {
    type: number
    sql: ${TABLE}.tgenabled ;;
  }

  dimension: tgfoid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tgfoid ;;
  }

  dimension: tginitdeferred {
    type: string
    sql: ${TABLE}.tginitdeferred ;;
  }

  dimension: tgisconstraint {
    type: number
    sql: ${TABLE}.tgisconstraint ;;
  }

  dimension: tgname {
    type: string
    sql: ${TABLE}.tgname ;;
  }

  dimension: tgnargs {
    type: number
    sql: ${TABLE}.tgnargs ;;
  }

  dimension: tgrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tgrelid ;;
  }

  dimension: tgtype {
    type: number
    sql: ${TABLE}.tgtype ;;
  }

  measure: count {
    type: count
    drill_fields: [tgconstrname, tgname]
  }
}
