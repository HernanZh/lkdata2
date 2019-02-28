view: pg_shdepend {
  sql_table_name: tenjin_BigQuery.pg_shdepend ;;

  dimension: classid {
    type: number
    value_format_name: id
    sql: ${TABLE}.classid ;;
  }

  dimension: dbid {
    type: number
    value_format_name: id
    sql: ${TABLE}.dbid ;;
  }

  dimension: deptype {
    type: string
    sql: ${TABLE}.deptype ;;
  }

  dimension: objid {
    type: number
    value_format_name: id
    sql: ${TABLE}.objid ;;
  }

  dimension: objsubid {
    type: number
    value_format_name: id
    sql: ${TABLE}.objsubid ;;
  }

  dimension: refclassid {
    type: number
    value_format_name: id
    sql: ${TABLE}.refclassid ;;
  }

  dimension: refobjid {
    type: number
    value_format_name: id
    sql: ${TABLE}.refobjid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
