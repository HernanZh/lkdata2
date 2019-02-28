view: pg_test {
  sql_table_name: tenjin_BigQuery.pg_test ;;

  dimension: tesbool {
    type: number
    sql: ${TABLE}.tesbool ;;
  }

  dimension: teschar {
    type: number
    sql: ${TABLE}.teschar ;;
  }

  dimension_group: tesdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.tesdate ;;
  }

  dimension: tesenum {
    type: string
    sql: ${TABLE}.tesenum ;;
  }

  dimension: tesfloat4 {
    type: number
    sql: ${TABLE}.tesfloat4 ;;
  }

  dimension: tesfloat8 {
    type: number
    sql: ${TABLE}.tesfloat8 ;;
  }

  dimension: tesint2 {
    type: number
    sql: ${TABLE}.tesint2 ;;
  }

  dimension: tesint4 {
    type: number
    sql: ${TABLE}.tesint4 ;;
  }

  dimension: tesint8 {
    type: number
    sql: ${TABLE}.tesint8 ;;
  }

  dimension_group: tesinterval {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.tesinterval ;;
  }

  dimension: tesname {
    type: string
    sql: ${TABLE}.tesname ;;
  }

  dimension: tesnumeric {
    type: number
    sql: ${TABLE}.tesnumeric ;;
  }

  dimension: tesoid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tesoid ;;
  }

  dimension: tesregproc {
    type: string
    sql: ${TABLE}.tesregproc ;;
  }

  dimension: testext {
    type: string
    sql: ${TABLE}.testext ;;
  }

  dimension: testid {
    type: number
    value_format_name: id
    sql: ${TABLE}.testid ;;
  }

  dimension_group: testimestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.testimestamp ;;
  }

  dimension: tesvarchar {
    type: string
    sql: ${TABLE}.tesvarchar ;;
  }

  dimension: tesxid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tesxid ;;
  }

  measure: count {
    type: count
    drill_fields: [tesname]
  }
}
