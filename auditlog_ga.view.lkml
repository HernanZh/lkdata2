view: auditlog_ga {
  sql_table_name: `innate-streamer-230808.game_analytics.cloudaudit_googleapis_com_data_access_*`
    ;;

  dimension: eventName {
    type: string
    sql: ${TABLE}.protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.eventName ;;
  }

  dimension_group: DateTime {
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
    sql: ${TABLE}.protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.endTime ;;
  }

  dimension: PrincipalEmail {
    type: string
    sql: ${TABLE}.protopayload_auditlog.authenticationInfo.principalEmail ;;
  }
  dimension: QueryPriority {
    type: string
    sql: ${TABLE}.protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobConfiguration.query.queryPriority ;;
  }
  dimension: Query {
    type: string
    sql:  ${TABLE}.protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobConfiguration.query.query;;
  }
  measure: TotalBytesBilled {
    type: number
    sql:  SUM(${TABLE}.protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.totalBilledBytes);;
  }

  measure: USDCentsCharge {
    type: number
    sql: ((((SUM(${TABLE}.protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.totalBilledBytes)/1024)/1024)/1024)/1024)*500 ;;
  }


  measure: USDCharge {
    type: number
    value_format: "$#,##0.00"
    sql: ((((SUM(${TABLE}.protopayload_auditlog.servicedata_v1_bigquery.jobCompletedEvent.job.jobStatistics.totalBilledBytes)/1024)/1024)/1024)/1024)*500 / 100 ;;
  }

}
