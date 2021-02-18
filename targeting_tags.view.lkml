view: targeting_tags {
  #sql_table_name: tenjin_BigQuery.targeting_tags ;;
  sql_table_name: tenjin_dv.targeting_tags ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.segment ;;
  }

  dimension: standard {
    type: number
    sql: ${TABLE}.standard ;;
  }

  measure: count {
    type: count
    drill_fields: [id, campaigns_targeting_tags.count]
  }
}
