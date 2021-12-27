view: SOL_transactions_head {
  sql_table_name: `lk-datawarehouse-2.sol_test_dataset.transactions_head`
    ;;

  dimension: block_time {
    type: number
    sql: ${TABLE}.block_time ;;
  }

  dimension: lk_begin_balance {
    type: number
    sql: ${TABLE}.lk_begin_balance ;;
  }

  dimension: lk_end_balance {
    type: number
    sql: ${TABLE}.lk_end_balance ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  measure: transaction_value_sol {
    type: sum
    sql: ${TABLE}.transaction_value ;;
  }

  dimension_group: utc {
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
    sql: ${TABLE}.utc_date ;;
  }

  dimension: wallet {
    type: string
    sql: ${TABLE}.wallet ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
