view: pg_attrdef {
  sql_table_name: tenjin_BigQuery.pg_attrdef ;;

  dimension: adbin {
    type: string
    sql: ${TABLE}.adbin ;;
  }

  dimension: adnum {
    type: number
    sql: ${TABLE}.adnum ;;
  }

  dimension: adrelid {
    type: number
    value_format_name: id
    sql: ${TABLE}.adrelid ;;
  }

  dimension: adsrc {
    type: yesno
    sql: ${TABLE}.adsrc ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
