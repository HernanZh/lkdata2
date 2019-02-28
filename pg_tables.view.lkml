view: pg_tables {
  sql_table_name: tenjin_BigQuery.pg_tables ;;

  dimension: hasindexes {
    type: number
    sql: ${TABLE}.hasindexes ;;
  }

  dimension: hasrules {
    type: string
    sql: ${TABLE}.hasrules ;;
  }

  dimension: hastriggers {
    type: number
    sql: ${TABLE}.hastriggers ;;
  }

  dimension: schemaname {
    type: string
    sql: ${TABLE}.schemaname ;;
  }

  dimension: tablename {
    type: string
    sql: ${TABLE}.tablename ;;
  }

  dimension: tableowner {
    type: string
    sql: ${TABLE}.tableowner ;;
  }

  dimension: tablespace {
    type: string
    sql: ${TABLE}.tablespace ;;
  }

  measure: count {
    type: count
    drill_fields: [schemaname, tablename]
  }
}
