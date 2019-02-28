view: pg_proc {
  sql_table_name: tenjin_BigQuery.pg_proc ;;

  dimension: proacl {
    type: string
    sql: ${TABLE}.proacl ;;
  }

  dimension: proargnames {
    type: string
    sql: ${TABLE}.proargnames ;;
  }

  dimension: proargtypes {
    type: string
    sql: ${TABLE}.proargtypes ;;
  }

  dimension: probin {
    type: string
    sql: ${TABLE}.probin ;;
  }

  dimension: proisagg {
    type: string
    sql: ${TABLE}.proisagg ;;
  }

  dimension: proisstrict {
    type: number
    sql: ${TABLE}.proisstrict ;;
  }

  dimension: prolang {
    type: number
    sql: ${TABLE}.prolang ;;
  }

  dimension: proname {
    type: string
    sql: ${TABLE}.proname ;;
  }

  dimension: pronamespace {
    type: number
    sql: ${TABLE}.pronamespace ;;
  }

  dimension: pronargs {
    type: number
    sql: ${TABLE}.pronargs ;;
  }

  dimension: proowner {
    type: number
    sql: ${TABLE}.proowner ;;
  }

  dimension: proretset {
    type: number
    sql: ${TABLE}.proretset ;;
  }

  dimension: prorettype {
    type: number
    sql: ${TABLE}.prorettype ;;
  }

  dimension: prosecdef {
    type: string
    sql: ${TABLE}.prosecdef ;;
  }

  dimension: prosrc {
    type: string
    sql: ${TABLE}.prosrc ;;
  }

  dimension: provolatile {
    type: string
    sql: ${TABLE}.provolatile ;;
  }

  measure: count {
    type: count
    drill_fields: [proname]
  }
}
