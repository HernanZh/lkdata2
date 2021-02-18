# view: cohort_behavior {
#   sql_table_name: tenjin_BigQuery.cohort_behavior ;;

#   dimension: campaign_id {
#     type: string
#     # hidden: yes
#     sql: ${TABLE}.campaign_id ;;
#   }

#   dimension: country {
#     type: string
#     map_layer_name: countries
#     sql: ${TABLE}.country ;;
#   }

#   dimension_group: date {
#     type: time
#     timeframes: [
#       raw,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     convert_tz: no
#     datatype: date
#     sql: ${TABLE}.date ;;
#   }

#   dimension: revenue {
#     type: number
#     sql: ${TABLE}.revenue ;;
#   }

#   dimension: sessions {
#     type: number
#     sql: ${TABLE}.sessions ;;
#   }

#   dimension: site_id {
#     type: string
#     sql: ${TABLE}.site_id ;;
#   }

#   dimension: transactions {
#     type: number
#     sql: ${TABLE}.transactions ;;
#   }

#   dimension: users {
#     type: number
#     sql: ${TABLE}.users ;;
#   }

#   dimension: xday {
#     type: number
#     sql: ${TABLE}.xday ;;
#   }

#   measure: dau {
#     type: sum
#     sql: ${TABLE}.users ;;
#   }

#   measure: rev {
#     type: sum
#     sql: ${TABLE}.revenue ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [campaigns.name, campaigns.id]
#   }
# }
