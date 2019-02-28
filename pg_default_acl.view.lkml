view: pg_default_acl {
  sql_table_name: tenjin_BigQuery.pg_default_acl ;;

  dimension: defaclacl {
    type: string
    sql: ${TABLE}.defaclacl ;;
  }

  dimension: defaclnamespace {
    type: number
    sql: ${TABLE}.defaclnamespace ;;
  }

  dimension: defaclobjtype {
    type: string
    sql: ${TABLE}.defaclobjtype ;;
  }

  dimension: defacluser {
    type: number
    sql: ${TABLE}.defacluser ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
