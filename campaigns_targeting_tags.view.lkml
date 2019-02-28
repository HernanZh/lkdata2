view: campaigns_targeting_tags {
  sql_table_name: tenjin_BigQuery.campaigns_targeting_tags ;;

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: targeting_tag_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.targeting_tag_id ;;
  }

  measure: count {
    type: count
    drill_fields: [targeting_tags.id, campaigns.name, campaigns.id]
  }
}
