view: sfd_power_ltv {
  sql_table_name: `lk-datawarehouse-2.sfd_firebase.sfd_power_ltv`
    ;;

  dimension_group: install {
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
    sql: ${TABLE}.install_date ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  measure: pred_d10_ltv {
    type: sum
    sql: ${TABLE}.pred_D10_LTV ;;
  }

  measure: pred_d11_ltv {
    type: sum
    sql: ${TABLE}.pred_D11_LTV ;;
  }

  measure: pred_d12_ltv {
    type: sum
    sql: ${TABLE}.pred_D12_LTV ;;
  }

  measure: pred_d13_ltv {
    type: sum
    sql: ${TABLE}.pred_D13_LTV ;;
  }

  measure: pred_d14_ltv {
    type: sum
    sql: ${TABLE}.pred_D14_LTV ;;
  }

  measure: pred_d15_ltv {
    type: sum
    sql: ${TABLE}.pred_D15_LTV ;;
  }

  measure: pred_d16_ltv {
    type: sum
    sql: ${TABLE}.pred_D16_LTV ;;
  }

  measure: pred_d17_ltv {
    type: sum
    sql: ${TABLE}.pred_D17_LTV ;;
  }

  measure: pred_d18_ltv {
    type: sum
    sql: ${TABLE}.pred_D18_LTV ;;
  }

  measure: pred_d19_ltv {
    type: sum
    sql: ${TABLE}.pred_D19_LTV ;;
  }

  measure: pred_d1_ltv {
    type: sum
    sql: ${TABLE}.pred_D1_LTV ;;
  }

  measure: pred_d20_ltv {
    type: sum
    sql: ${TABLE}.pred_D20_LTV ;;
  }

  measure: pred_d21_ltv {
    type: sum
    sql: ${TABLE}.pred_D21_LTV ;;
  }

  measure: pred_d22_ltv {
    type: sum
    sql: ${TABLE}.pred_D22_LTV ;;
  }

  measure: pred_d23_ltv {
    type: sum
    sql: ${TABLE}.pred_D23_LTV ;;
  }

  measure: pred_d24_ltv {
    type: sum
    sql: ${TABLE}.pred_D24_LTV ;;
  }

  measure: pred_d25_ltv {
    type: sum
    sql: ${TABLE}.pred_D25_LTV ;;
  }

  measure: pred_d26_ltv {
    type: sum
    sql: ${TABLE}.pred_D26_LTV ;;
  }

  measure: pred_d27_ltv {
    type: sum
    sql: ${TABLE}.pred_D27_LTV ;;
  }

  measure: pred_d28_ltv {
    type: sum
    sql: ${TABLE}.pred_D28_LTV ;;
  }

  measure: pred_d29_ltv {
    type: sum
    sql: ${TABLE}.pred_D29_LTV ;;
  }

  measure: pred_d2_ltv {
    type: sum
    sql: ${TABLE}.pred_D2_LTV ;;
  }

  measure: pred_d30_ltv {
    type: sum
    sql: ${TABLE}.pred_D30_LTV ;;
  }

  measure: pred_d3_ltv {
    type: sum
    sql: ${TABLE}.pred_D3_LTV ;;
  }

  measure: pred_d4_ltv {
    type: sum
    sql: ${TABLE}.pred_D4_LTV ;;
  }

  measure: pred_d5_ltv {
    type: sum
    sql: ${TABLE}.pred_D5_LTV ;;
  }

  measure: pred_d6_ltv {
    type: sum
    sql: ${TABLE}.pred_D6_LTV ;;
  }

  measure: pred_d7_ltv {
    type: sum
    sql: ${TABLE}.pred_D7_LTV ;;
  }

  measure: pred_d8_ltv {
    type: sum
    sql: ${TABLE}.pred_D8_LTV ;;
  }

  measure: pred_d9_ltv {
    type: sum
    sql: ${TABLE}.pred_D9_LTV ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
