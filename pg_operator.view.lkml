view: pg_operator {
  sql_table_name: tenjin_BigQuery.pg_operator ;;

  dimension: oprcanhash {
    type: number
    sql: ${TABLE}.oprcanhash ;;
  }

  dimension: oprcode {
    type: string
    sql: ${TABLE}.oprcode ;;
  }

  dimension: oprcom {
    type: number
    sql: ${TABLE}.oprcom ;;
  }

  dimension: oprgtcmpop {
    type: number
    sql: ${TABLE}.oprgtcmpop ;;
  }

  dimension: oprjoin {
    type: string
    sql: ${TABLE}.oprjoin ;;
  }

  dimension: oprkind {
    type: string
    sql: ${TABLE}.oprkind ;;
  }

  dimension: oprleft {
    type: number
    sql: ${TABLE}.oprleft ;;
  }

  dimension: oprlsortop {
    type: number
    sql: ${TABLE}.oprlsortop ;;
  }

  dimension: oprltcmpop {
    type: number
    sql: ${TABLE}.oprltcmpop ;;
  }

  dimension: oprname {
    type: string
    sql: ${TABLE}.oprname ;;
  }

  dimension: oprnamespace {
    type: number
    sql: ${TABLE}.oprnamespace ;;
  }

  dimension: oprnegate {
    type: number
    sql: ${TABLE}.oprnegate ;;
  }

  dimension: oprowner {
    type: number
    sql: ${TABLE}.oprowner ;;
  }

  dimension: oprrest {
    type: string
    sql: ${TABLE}.oprrest ;;
  }

  dimension: oprresult {
    type: number
    sql: ${TABLE}.oprresult ;;
  }

  dimension: oprright {
    type: number
    sql: ${TABLE}.oprright ;;
  }

  dimension: oprrsortop {
    type: number
    sql: ${TABLE}.oprrsortop ;;
  }

  measure: count {
    type: count
    drill_fields: [oprname]
  }
}
