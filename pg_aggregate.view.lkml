view: pg_aggregate {
  sql_table_name: tenjin_BigQuery.pg_aggregate ;;

  dimension: aggfinalfn {
    type: string
    sql: ${TABLE}.aggfinalfn ;;
  }

  dimension: aggfnoid {
    type: string
    sql: ${TABLE}.aggfnoid ;;
  }

  dimension: agginitval {
    type: string
    sql: ${TABLE}.agginitval ;;
  }

  dimension: aggtransfn {
    type: string
    sql: ${TABLE}.aggtransfn ;;
  }

  dimension: aggtranstype {
    type: number
    sql: ${TABLE}.aggtranstype ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
