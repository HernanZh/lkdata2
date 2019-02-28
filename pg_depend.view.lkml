view: pg_depend {
  sql_table_name: tenjin_BigQuery.pg_depend ;;

  dimension: classid {
    type: number
    value_format_name: id
    sql: ${TABLE}.classid ;;
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

  dimension: refobjsubid {
    type: number
    value_format_name: id
    sql: ${TABLE}.refobjsubid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
