view: dog_owners {
  sql_table_name: `lk-datawarehouse-2.sol_test_dataset.dog_owners`
    ;;

  dimension_group: acquisition {
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
    sql: ${TABLE}.acquisition_time ;;
  }

  dimension: dog_token {
    type: string
    sql: ${TABLE}.dog_token ;;
  }

  dimension: holder {
    type: string
    sql: ${TABLE}.holder ;;
  }

  measure: holder_sol {
    type: average
    sql: ${TABLE}.holder_SOL ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: owners {
    type: count_distinct
    sql: ${TABLE}.holder ;;
  }

  measure: Panzerdogs {
    type: count_distinct
    sql: ${TABLE}.dog_token ;;
  }
}
