view: pg_class {
  sql_table_name: tenjin_BigQuery.pg_class ;;

  dimension: relacl {
    type: string
    sql: ${TABLE}.relacl ;;
  }

  dimension: relam {
    type: number
    sql: ${TABLE}.relam ;;
  }

  dimension: relchecks {
    type: number
    sql: ${TABLE}.relchecks ;;
  }

  dimension: reldiststyle {
    type: number
    sql: ${TABLE}.reldiststyle ;;
  }

  dimension: relexternid {
    type: number
    value_format_name: id
    sql: ${TABLE}.relexternid ;;
  }

  dimension: relfilenode {
    type: number
    sql: ${TABLE}.relfilenode ;;
  }

  dimension: relfkeys {
    type: number
    sql: ${TABLE}.relfkeys ;;
  }

  dimension: relhasindex {
    type: number
    sql: ${TABLE}.relhasindex ;;
  }

  dimension: relhasoids {
    type: number
    sql: ${TABLE}.relhasoids ;;
  }

  dimension: relhaspkey {
    type: number
    sql: ${TABLE}.relhaspkey ;;
  }

  dimension: relhasrules {
    type: number
    sql: ${TABLE}.relhasrules ;;
  }

  dimension: relhassubclass {
    type: string
    sql: ${TABLE}.relhassubclass ;;
  }

  dimension: relispinned {
    type: string
    sql: ${TABLE}.relispinned ;;
  }

  dimension: relisreplicated {
    type: string
    sql: ${TABLE}.relisreplicated ;;
  }

  dimension: relisshared {
    type: number
    sql: ${TABLE}.relisshared ;;
  }

  dimension: relkind {
    type: string
    sql: ${TABLE}.relkind ;;
  }

  dimension: relname {
    type: string
    sql: ${TABLE}.relname ;;
  }

  dimension: relnamespace {
    type: number
    sql: ${TABLE}.relnamespace ;;
  }

  dimension: relnatts {
    type: number
    sql: ${TABLE}.relnatts ;;
  }

  dimension: relowner {
    type: number
    sql: ${TABLE}.relowner ;;
  }

  dimension: relpages {
    type: number
    sql: ${TABLE}.relpages ;;
  }

  dimension: relprojbaseid {
    type: number
    value_format_name: id
    sql: ${TABLE}.relprojbaseid ;;
  }

  dimension: relrefs {
    type: number
    sql: ${TABLE}.relrefs ;;
  }

  dimension: reltablespace {
    type: number
    sql: ${TABLE}.reltablespace ;;
  }

  dimension: reltoastidxid {
    type: number
    value_format_name: id
    sql: ${TABLE}.reltoastidxid ;;
  }

  dimension: reltoastrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.reltoastrelid ;;
  }

  dimension: reltriggers {
    type: number
    sql: ${TABLE}.reltriggers ;;
  }

  dimension: reltuples {
    type: number
    sql: ${TABLE}.reltuples ;;
  }

  dimension: reltype {
    type: number
    sql: ${TABLE}.reltype ;;
  }

  dimension: relukeys {
    type: number
    sql: ${TABLE}.relukeys ;;
  }

  measure: count {
    type: count
    drill_fields: [relname]
  }
}
