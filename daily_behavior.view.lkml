view: daily_behavior {
  sql_table_name: tenjin_BigQuery.daily_behavior ;;

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: monthly_users {
    type: string
    sql: ${TABLE}.monthly_users ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  dimension: transactions {
    type: number
    sql: ${TABLE}.transactions ;;
  }

  dimension: users {
    type: number
    sql: ${TABLE}.users ;;
  }

  dimension: weekly_users {
    type: number
    sql: ${TABLE}.weekly_users ;;
  }

  measure: count {
    type: count
    drill_fields: [campaigns.name, campaigns.id]
  }
}
