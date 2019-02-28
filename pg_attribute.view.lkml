view: pg_attribute {
  sql_table_name: tenjin_BigQuery.pg_attribute ;;

  dimension: attalign {
    type: string
    sql: ${TABLE}.attalign ;;
  }

  dimension: attbyval {
    type: number
    sql: ${TABLE}.attbyval ;;
  }

  dimension: attcacheoff {
    type: number
    sql: ${TABLE}.attcacheoff ;;
  }

  dimension: attencodingtype {
    type: number
    sql: ${TABLE}.attencodingtype ;;
  }

  dimension: attencrypttype {
    type: number
    sql: ${TABLE}.attencrypttype ;;
  }

  dimension: atthasdef {
    type: string
    sql: ${TABLE}.atthasdef ;;
  }

  dimension: attinhcount {
    type: number
    sql: ${TABLE}.attinhcount ;;
  }

  dimension: attisdistkey {
    type: string
    sql: ${TABLE}.attisdistkey ;;
  }

  dimension: attisdropped {
    type: string
    sql: ${TABLE}.attisdropped ;;
  }

  dimension: attislocal {
    type: number
    sql: ${TABLE}.attislocal ;;
  }

  dimension: attispreloaded {
    type: string
    sql: ${TABLE}.attispreloaded ;;
  }

  dimension: attlen {
    type: number
    sql: ${TABLE}.attlen ;;
  }

  dimension: attname {
    type: string
    sql: ${TABLE}.attname ;;
  }

  dimension: attndims {
    type: number
    sql: ${TABLE}.attndims ;;
  }

  dimension: attnotnull {
    type: number
    sql: ${TABLE}.attnotnull ;;
  }

  dimension: attnum {
    type: number
    sql: ${TABLE}.attnum ;;
  }

  dimension: attrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.attrelid ;;
  }

  dimension: attsortkeyord {
    type: number
    sql: ${TABLE}.attsortkeyord ;;
  }

  dimension: attstattarget {
    type: number
    sql: ${TABLE}.attstattarget ;;
  }

  dimension: attstorage {
    type: string
    sql: ${TABLE}.attstorage ;;
  }

  dimension: atttypid {
    type: number
    value_format_name: id
    sql: ${TABLE}.atttypid ;;
  }

  dimension: atttypmod {
    type: number
    sql: ${TABLE}.atttypmod ;;
  }

  measure: count {
    type: count
    drill_fields: [attname]
  }
}
