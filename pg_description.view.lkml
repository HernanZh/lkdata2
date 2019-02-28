view: pg_description {
  sql_table_name: tenjin_BigQuery.pg_description ;;

  dimension: classoid {
    type: number
    value_format_name: id
    sql: ${TABLE}.classoid ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: objoid {
    type: number
    value_format_name: id
    sql: ${TABLE}.objoid ;;
  }

  dimension: objsubid {
    type: number
    value_format_name: id
    sql: ${TABLE}.objsubid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
