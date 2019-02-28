view: pg_type {
  sql_table_name: tenjin_BigQuery.pg_type ;;

  dimension: typalign {
    type: string
    sql: ${TABLE}.typalign ;;
  }

  dimension: typanalyze {
    type: string
    sql: ${TABLE}.typanalyze ;;
  }

  dimension: typbasetype {
    type: number
    sql: ${TABLE}.typbasetype ;;
  }

  dimension: typbyval {
    type: number
    sql: ${TABLE}.typbyval ;;
  }

  dimension: typdefault {
    type: string
    sql: ${TABLE}.typdefault ;;
  }

  dimension: typdefaultbin {
    type: string
    sql: ${TABLE}.typdefaultbin ;;
  }

  dimension: typdelim {
    type: string
    sql: ${TABLE}.typdelim ;;
  }

  dimension: typelem {
    type: number
    sql: ${TABLE}.typelem ;;
  }

  dimension: typinput {
    type: string
    sql: ${TABLE}.typinput ;;
  }

  dimension: typisdefined {
    type: number
    sql: ${TABLE}.typisdefined ;;
  }

  dimension: typlen {
    type: number
    sql: ${TABLE}.typlen ;;
  }

  dimension: typname {
    type: string
    sql: ${TABLE}.typname ;;
  }

  dimension: typnamespace {
    type: number
    sql: ${TABLE}.typnamespace ;;
  }

  dimension: typndims {
    type: number
    sql: ${TABLE}.typndims ;;
  }

  dimension: typnotnull {
    type: string
    sql: ${TABLE}.typnotnull ;;
  }

  dimension: typoutput {
    type: string
    sql: ${TABLE}.typoutput ;;
  }

  dimension: typowner {
    type: number
    sql: ${TABLE}.typowner ;;
  }

  dimension: typreceive {
    type: string
    sql: ${TABLE}.typreceive ;;
  }

  dimension: typrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.typrelid ;;
  }

  dimension: typsend {
    type: string
    sql: ${TABLE}.typsend ;;
  }

  dimension: typstorage {
    type: string
    sql: ${TABLE}.typstorage ;;
  }

  dimension: typtype {
    type: string
    sql: ${TABLE}.typtype ;;
  }

  dimension: typtypmod {
    type: number
    sql: ${TABLE}.typtypmod ;;
  }

  measure: count {
    type: count
    drill_fields: [typname]
  }
}
