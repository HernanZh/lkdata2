view: pg_opclass {
  sql_table_name: tenjin_BigQuery.pg_opclass ;;

  dimension: opcamid {
    type: number
    value_format_name: id
    sql: ${TABLE}.opcamid ;;
  }

  dimension: opcdefault {
    type: number
    sql: ${TABLE}.opcdefault ;;
  }

  dimension: opcintype {
    type: number
    sql: ${TABLE}.opcintype ;;
  }

  dimension: opckeytype {
    type: number
    sql: ${TABLE}.opckeytype ;;
  }

  dimension: opcname {
    type: string
    sql: ${TABLE}.opcname ;;
  }

  dimension: opcnamespace {
    type: number
    sql: ${TABLE}.opcnamespace ;;
  }

  dimension: opcowner {
    type: number
    sql: ${TABLE}.opcowner ;;
  }

  measure: count {
    type: count
    drill_fields: [opcname]
  }
}
