view: pg_rewrite {
  sql_table_name: tenjin_BigQuery.pg_rewrite ;;

  dimension: ev_action {
    type: string
    sql: ${TABLE}.ev_action ;;
  }

  dimension: ev_attr {
    type: number
    sql: ${TABLE}.ev_attr ;;
  }

  dimension: ev_class {
    type: number
    sql: ${TABLE}.ev_class ;;
  }

  dimension: ev_qual {
    type: string
    sql: ${TABLE}.ev_qual ;;
  }

  dimension: ev_type {
    type: number
    sql: ${TABLE}.ev_type ;;
  }

  dimension: is_instead {
    type: number
    sql: ${TABLE}.is_instead ;;
  }

  dimension: rulename {
    type: string
    sql: ${TABLE}.rulename ;;
  }

  measure: count {
    type: count
    drill_fields: [rulename]
  }
}
