view: pg_am {
  sql_table_name: tenjin_BigQuery.pg_am ;;

  dimension: ambeginscan {
    type: string
    sql: ${TABLE}.ambeginscan ;;
  }

  dimension: ambuild {
    type: string
    sql: ${TABLE}.ambuild ;;
  }

  dimension: ambulkdelete {
    type: string
    sql: ${TABLE}.ambulkdelete ;;
  }

  dimension: amcanmulticol {
    type: number
    sql: ${TABLE}.amcanmulticol ;;
  }

  dimension: amcanunique {
    type: number
    sql: ${TABLE}.amcanunique ;;
  }

  dimension: amconcurrent {
    type: number
    sql: ${TABLE}.amconcurrent ;;
  }

  dimension: amcostestimate {
    type: string
    sql: ${TABLE}.amcostestimate ;;
  }

  dimension: amendscan {
    type: string
    sql: ${TABLE}.amendscan ;;
  }

  dimension: amgettuple {
    type: string
    sql: ${TABLE}.amgettuple ;;
  }

  dimension: amindexnulls {
    type: number
    sql: ${TABLE}.amindexnulls ;;
  }

  dimension: aminsert {
    type: string
    sql: ${TABLE}.aminsert ;;
  }

  dimension: ammarkpos {
    type: string
    sql: ${TABLE}.ammarkpos ;;
  }

  dimension: amname {
    type: string
    sql: ${TABLE}.amname ;;
  }

  dimension: amorderstrategy {
    type: number
    sql: ${TABLE}.amorderstrategy ;;
  }

  dimension: amowner {
    type: number
    sql: ${TABLE}.amowner ;;
  }

  dimension: amrescan {
    type: string
    sql: ${TABLE}.amrescan ;;
  }

  dimension: amrestrpos {
    type: string
    sql: ${TABLE}.amrestrpos ;;
  }

  dimension: amstrategies {
    type: number
    sql: ${TABLE}.amstrategies ;;
  }

  dimension: amsupport {
    type: number
    sql: ${TABLE}.amsupport ;;
  }

  dimension: amvacuumcleanup {
    type: string
    sql: ${TABLE}.amvacuumcleanup ;;
  }

  measure: count {
    type: count
    drill_fields: [amname]
  }
}
