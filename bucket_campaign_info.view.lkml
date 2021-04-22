view: bucket_campaign_info {
  sql_table_name: tenjin_dv.bucket_campaign_info ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: ad_network_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ad_network_id ;;
  }

  dimension: app_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.app_id ;;
  }

  dimension: is_bucket {
    type: number
    sql: ${TABLE}.is_bucket ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      apps.name,
      apps.id,
      ad_networks.name,
      ad_networks.id
    ]
  }
}
