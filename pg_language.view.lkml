view: pg_language {
  sql_table_name: tenjin_BigQuery.pg_language ;;

  dimension: lanacl {
    type: string
    sql: ${TABLE}.lanacl ;;
  }

  dimension: lanispl {
    type: number
    sql: ${TABLE}.lanispl ;;
  }

  dimension: lanname {
    type: string
    sql: ${TABLE}.lanname ;;
  }

  dimension: lanplcallfoid {
    type: number
    value_format_name: id
    sql: ${TABLE}.lanplcallfoid ;;
  }

  dimension: lanpltrusted {
    type: number
    sql: ${TABLE}.lanpltrusted ;;
  }

  dimension: lanvalidator {
    type: number
    sql: ${TABLE}.lanvalidator ;;
  }

  measure: count {
    type: count
    drill_fields: [lanname]
  }
}
