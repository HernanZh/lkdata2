#connection: "lk-datawarehouse"
connection: "lk-datawarehouse-2"

# include all the views
include: "*.view"

datagroup: lk_datawarehouse2_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hours"
}

persist_with: lk_datawarehouse2_default_datagroup

# explore: d_conversionValue {}

#   explore: nit_events {
#     label: "nit events"

# ## TO avoid querying the entire database by default, suggest setting up a filter like below, and perhaps limiting GB scanned with 'Max Billing Gigabytes' in the connection
#     always_filter: {
#       filters: {
#         field: event_date
#         value: "last 7 days"
#       }
#     }

#     join: nit_events__event_params {
#       view_label: "Event Properties"
#       sql: LEFT JOIN UNNEST(nit_events.event_params) as nit_events__event_params ;;
#       relationship: one_to_many
#     }

#     join: nit_events__event_params__value{
#       view_label: "Event Properties"
#       sql: LEFT JOIN UNNEST([nit_events__event_params.value]) as nit_events__event_params__value ;;
#       relationship: one_to_many
#     }

#     join: nit_events__user_properties {
#       sql: LEFT JOIN UNNEST(nit_events.user_properties) as nit_events__user_properties ;;
#       view_label: "User Properties"
#       relationship: one_to_many
#     }

#     join: nit_events__user_properties__value {
#       view_label: "User Properties"
#       sql: LEFT JOIN UNNEST([nit_events__user_properties.value]) as nit_events__user_properties__value ;;
#       relationship: one_to_many
#     }

#     join: nit_sessions {
#       sql_on: ${nit_events.user_pseudo_id} = ${nit_sessions.user_pseudo_id}
#           AND ${nit_events._event_raw} >= ${nit_sessions.session_start_raw}
#           AND ${nit_events._event_raw} <= ${nit_sessions.session_end_raw} ;;
#       relationship: many_to_one
#     }

#     join: events {
#       type: left_outer
#       sql_on: lower(replace(${nit_events.advertising_id},'-',""))=${events.advertising_id} ;;
#       relationship: one_to_one
#     }

#     join: campaigns {
#       type: left_outer
#       sql_on: ${events.source_campaign_id} = ${campaigns.id} ;;
#       relationship: many_to_one
#       }

#       join: ad_networks {
#         type: left_outer
#         sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
#         relationship: many_to_one
#       }

#       join: apps {
#         type: left_outer
#         sql_on: ${campaigns.app_id} = ${apps.id} ;;
#         relationship: many_to_one
#       }

#       join: campaign_buckets {
#         type: left_outer
#         sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
#         relationship: many_to_one
#       }

#     # explore: user_attributes {
#     #   join: campaigns {
#     #     type: left_outer
#     #     sql_on: ${user_attributes.campaign_id} = ${campaigns.id} ;;
#     #     relationship: many_to_one
#     #   }

#     #   join: ad_networks {
#     #     type: left_outer
#     #     sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
#     #     relationship: many_to_one
#     #   }

#     #   join: apps {
#     #     type: left_outer
#     #     sql_on: ${campaigns.app_id} = ${apps.id} ;;
#     #     relationship: many_to_one
#     #   }

#     #   join: campaign_buckets {
#     #     type: left_outer
#     #     sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
#     #     relationship: many_to_one
#     #   }
#     # }
#     }


# explore: user_ad_revenue_old {
#   join: events {
#     type: left_outer
#     sql_on: ${events.advertising_id} = ${user_ad_revenue_old.advertising_id} ;;
#     relationship: many_to_one
#   }

#   join: campaigns {
#     type: left_outer
#     sql_on: ${events.source_campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }

#   join: apps {
#     type: left_outer
#     sql_on: ${campaigns.app_id} = ${apps.id} ;;
#     relationship: many_to_one
#   }

#   join: ad_networks {
#     type: left_outer
#     sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
#     relationship: many_to_one
#   }

# }

explore: mf_test {}

include: "Panzerdogs/sol_price.view"
explore: sol_price {
  group_label: "Panzerdogs"
}

include: "Panzerdogs/transactions_head.view"
explore: SOL_transactions_head {
  group_label: "Panzerdogs"
}


explore: ad_engagements {
  join: apps {
    type: left_outer
    sql_on: ${ad_engagements.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${ad_engagements.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: ad_networks {}

explore: apps {}

explore: reporting_cohorted_revenue {
  join: ad_networks {
    type: left_outer
    sql_on: ${reporting_cohorted_revenue.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${reporting_cohorted_revenue.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: bucket_campaign_info {
    type: left_outer
    sql_on: ${reporting_cohorted_revenue.campaign_id} = ${bucket_campaign_info.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${reporting_cohorted_revenue.campaign_id} = ${campaigns.id} ;;
#     sql_on: (${bucket_campaign_info.id} = ${campaigns.campaign_bucket_id} OR ${reporting_cohorted_revenue.campaign_id} = ${campaigns.id}) ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }

  join: reporting_metrics {
    type: left_outer
    relationship: many_to_one
    sql_on: ${reporting_metrics.date_date} = ${reporting_cohorted_revenue.date}
    AND ${reporting_metrics.app_id} = ${reporting_cohorted_revenue.app_id}
    AND ${reporting_metrics.campaign_id} = ${reporting_cohorted_revenue.campaign_id}
    AND ${reporting_metrics.site_id} = ${reporting_cohorted_revenue.site_id}
    AND ${reporting_metrics.country} = ${reporting_cohorted_revenue.country}
    AND ${reporting_metrics.platform} = ${reporting_cohorted_revenue.platform};;
    fields: [reporting_metrics.rep_spend, reporting_metrics.org_installs,reporting_metrics.track_installs]
  }

  # join: reporting_metrics {
  #   type: left_outer
  #   sql_on: ${reporting_cohorted_revenue.ad_network_id} = ${reporting_metrics.ad_network_id} AND
  #         ${reporting_cohorted_revenue.app_id} = ${reporting_metrics.app_id} AND
  #         ${reporting_cohorted_revenue.campaign_id} = ${reporting_metrics.campaign_id} AND
  #         ${reporting_cohorted_revenue.site_id} = ${reporting_metrics.site_id} AND
  #         ${reporting_cohorted_revenue.country} = ${reporting_metrics.country} AND
  #         ${reporting_cohorted_revenue.install_date} = ${reporting_metrics.date_date} AND
  #         ${reporting_cohorted_revenue.platform} = ${reporting_metrics.platform}
  #         ;;
  #   relationship: many_to_one
  # }

  # join: SKAdNetwork_Test {
  #   type: left_outer
  #   sql_on: ${SKAdNetwork_Test.created_date} = ${reporting_cohorted_revenue.date} ;;
  #   relationship: one_to_one
  # }
}

explore: bucket_campaign_info {
  join: apps {
    type: left_outer
    sql_on: ${bucket_campaign_info.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${bucket_campaign_info.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: campaign_buckets {
  join: apps {
    type: left_outer
    sql_on: ${campaign_buckets.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaign_buckets.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: campaigns {
  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${campaigns.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: campaigns_targeting_tags {
  join: targeting_tags {
    type: left_outer
    sql_on: ${campaigns_targeting_tags.targeting_tag_id} = ${targeting_tags.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${campaigns_targeting_tags.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${campaigns.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: countries {}

explore: daily_ad_revenue {
  join: publisher_apps {
    type: left_outer
    sql_on: ${daily_ad_revenue.publisher_app_id} = ${publisher_apps.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${publisher_apps.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${publisher_apps.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: daily_country_spend {
  join: campaigns {
    type: left_outer
    sql_on: ${daily_country_spend.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${campaigns.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: daily_spend {
  join: campaigns {
    type: left_outer
    sql_on: ${daily_spend.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${campaigns.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: events {
  join: apps {
    type: left_outer
    sql_on: ${events.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${events.source_campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }

}


explore: publisher_apps {
  join: apps {
    type: left_outer
    sql_on: ${publisher_apps.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${publisher_apps.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }
}

explore: reporting_cohort_metrics {
  join: ad_networks {
    type: left_outer
    sql_on: ${reporting_cohort_metrics.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${reporting_cohort_metrics.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: bucket_campaign_info {
    type: left_outer
    sql_on: ${reporting_cohort_metrics.campaign_id} = ${bucket_campaign_info.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${reporting_cohort_metrics.campaign_id} = ${campaigns.id} ;;
#     sql_on: (${bucket_campaign_info.id} = ${campaigns.campaign_bucket_id}) OR (${reporting_cohort_metrics.campaign_id} = ${campaigns.id}) ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }

  # join: reporting_metrics {
  #   type: left_outer
  #   sql_on: ${reporting_cohort_metrics.ad_network_id} = ${reporting_metrics.ad_network_id} AND
  #         ${reporting_cohort_metrics.app_id} = ${reporting_metrics.app_id} AND
  #         ${reporting_cohort_metrics.campaign_id} = ${reporting_metrics.campaign_id} AND
  #         ${reporting_cohort_metrics.site_id} = ${reporting_metrics.site_id} AND
  #         ${reporting_cohort_metrics.country} = ${reporting_metrics.country} AND
  #         ${reporting_cohort_metrics.install_date} = ${reporting_metrics.date_date} AND
  #         ${reporting_cohort_metrics.platform} = ${reporting_metrics.platform}
  #         ;;
  #   relationship: many_to_one
  # }

  # join: sk_ad_network_metrics {
  #   type: inner
  #   sql_on: ${reporting_cohort_metrics.app_id}=${sk_ad_network_metrics.app_id} AND
  #   ${reporting_cohort_metrics.install_date}=${sk_ad_network_metrics.date_date} AND
  #   ${reporting_cohort_metrics.ad_network_id}=${sk_ad_network_metrics.ad_network_id}
  #   ;;relationship: one_to_one

  # }


}

# explore: reporting_metrics_Trac_Ins {
#   join: ad_networks {
#     type: left_outer
#     sql_on: ${reporting_metrics_Trac_Ins.ad_network_id} = ${ad_networks.id} ;;
#     relationship: many_to_one
#   }

#   join: apps {
#     type: left_outer
#     sql_on: ${reporting_metrics_Trac_Ins.app_id} = ${apps.id} ;;
#     relationship: many_to_one
#   }

#   join: campaigns {
#     type: left_outer
#     sql_on: ${reporting_metrics_Trac_Ins.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }

#   join: campaign_buckets {
#     type: left_outer
#     sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
#     relationship: many_to_one
#   }
# }

explore: reporting_metrics {
  join: ad_networks {
    type: left_outer
    sql_on: ${reporting_metrics.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${reporting_metrics.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: bucket_campaign_info {
    type: left_outer
    sql_on: ${reporting_metrics.campaign_id} = ${bucket_campaign_info.id} ;;
    relationship: many_to_one
  }

#   join: campaigns {
#     type: left_outer
# #     sql_on: ${reporting_metrics.campaign_id} = ${campaigns.id} ;;
#     sql_on: ${bucket_campaign_info.id} = ${campaigns.campaign_bucket_id} OR ${reporting_metrics.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }

  join: campaigns {
    type: left_outer
    sql_on: ${reporting_metrics.campaign_id} = ${campaigns.id} ;;
#     sql_on: (${bucket_campaign_info.id} = ${campaigns.campaign_bucket_id}) OR (${reporting_metrics.campaign_id} = ${campaigns.id}) ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }
}

explore: reporting_metrics_with_max {
  join: ad_networks {
    type: left_outer
    sql_on: ${reporting_metrics_with_max.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${reporting_metrics_with_max.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: bucket_campaign_info {
    type: left_outer
    sql_on: ${reporting_metrics_with_max.campaign_id} = ${bucket_campaign_info.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${reporting_metrics_with_max.campaign_id} = ${campaigns.id} ;;
#     sql_on: (${bucket_campaign_info.id} = ${campaigns.campaign_bucket_id}) OR (${reporting_metrics.campaign_id} = ${campaigns.id}) ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }
}

explore: reporting_cohort_metrics_with_max {
  join: ad_networks {
    type: left_outer
    sql_on: ${reporting_cohort_metrics_with_max.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${reporting_cohort_metrics_with_max.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: bucket_campaign_info {
    type: left_outer
    sql_on: ${reporting_cohort_metrics_with_max.campaign_id} = ${bucket_campaign_info.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${reporting_cohort_metrics_with_max.campaign_id} = ${campaigns.id} ;;
#     sql_on: (${bucket_campaign_info.id} = ${campaigns.campaign_bucket_id}) OR (${reporting_cohort_metrics.campaign_id} = ${campaigns.id}) ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }
  }





# explore: user_ad_revenue_cohort {}

# explore: user_cohorts {
#   join: campaigns {
#     type: left_outer
#     sql_on: ${user_cohorts.campaign_id}= ${campaigns.id} ;;
#     relationship: many_to_one
#   }

#   join: reporting_metrics {
#     type: left_outer
#     sql_on: ${user_cohorts.campaign_id}= ${reporting_metrics.campaign_id} ;;
#     relationship: many_to_many

#   }

# }


explore: targeting_tags {}

#explore: updated_at {}


explore: user_attributes {
  join: campaigns {
    type: left_outer
    sql_on: ${user_attributes.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: many_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${campaigns.app_id} = ${apps.id} ;;
    relationship: many_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: many_to_one
  }
}

explore: sk_ad_network_metrics_new {
  join: apps {
    type: inner
    sql_on: ${apps.id}=${sk_ad_network_metrics_new.app_id} ;;
    relationship: one_to_one
  }
  join: ad_networks{
    type: inner
    sql_on: ${ad_networks.id}=${sk_ad_network_metrics_new.ad_network_id} ;;
    relationship: one_to_one
  }
}
explore: sk_ad_network_metrics {
  join: apps {
    type: inner
    sql_on: ${apps.id}=${sk_ad_network_metrics.app_id} ;;
    relationship: one_to_one
  }
  join: ad_networks{
    type: inner
    sql_on: ${ad_networks.id}=${sk_ad_network_metrics.ad_network_id} ;;
    relationship: one_to_one
  }
}

include: "/rc_firebase/rc_events.view"
include: "/rc_firebase/rc_sessions.view"
include: "/rc_firebase/rc_attribution.view"

explore: rc_attribution {
  label: "rc attribution"
  group_label: "Attribution"
}

explore: rc_events {
  label: "rc events"

## TO avoid querying the entire database by default, suggest setting up a filter like below, and perhaps limiting GB scanned with 'Max Billing Gigabytes' in the connection
  always_filter: {
    filters: {
      field: event_date
      value: "last 7 days"
    }
  }

  join: rc_events__event_params {
    view_label: "Event Properties"
    sql: LEFT JOIN UNNEST(rc_events.event_params) as rc_events__event_params ;;
    relationship: one_to_many
  }

  join: rc_events__event_params__value{
    view_label: "Event Properties"
    sql: LEFT JOIN UNNEST([rc_events__event_params.value]) as rc_events__event_params__value ;;
    relationship: one_to_many
  }

  join: rc_events__user_properties {
    sql: LEFT JOIN UNNEST(rc_events.user_properties) as rc_events__user_properties ;;
    view_label: "User Properties"
    relationship: one_to_many
  }

  join: rc_events__user_properties__value {
    view_label: "User Properties"
    sql: LEFT JOIN UNNEST([rc_events__user_properties.value]) as rc_events__user_properties__value ;;
    relationship: one_to_many
  }

  join: rc_sessions {
    sql_on: ${rc_events.user_pseudo_id} = ${rc_sessions.user_pseudo_id}
          AND ${rc_events._event_raw} >= ${rc_sessions.session_start_raw}
          AND ${rc_events._event_raw} <= ${rc_sessions.session_end_raw} ;;
    relationship: many_to_one
  }

  join: events {
    type: inner
    sql_on: lower(replace(${rc_events.advertising_id},'-',""))=COALESCE(${events.advertising_id},${events.developer_device_id})
    and lower(${rc_events.platform}) = ${events.platform} ;;
    #and ${rc_events.event_date} = ${events.created_date};;
    relationship: one_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${events.source_campaign_id} = ${campaigns.id} ;;
    relationship: one_to_one
  }

  join: ad_networks {
    type: left_outer
    sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
    relationship: one_to_one
  }

  join: apps {
    type: left_outer
    sql_on: ${campaigns.app_id} = ${apps.id} ;;
    relationship: one_to_one
  }

  join: campaign_buckets {
    type: left_outer
    sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
    relationship: one_to_one
  }
}


# include: "armed_firebase/armed_max_attribution.view"
# explore: armed_max_attribution {
#   group_label: "Attribution"
# }

include: "rh_firebase/rh_attribution.view"
explore: rh_attribution {
  group_label: "Attribution"
}

include: "rh_firebase/rh_ecpm.view"
explore: rh_ecpm {
  group_label: "Attribution"
}

include: "sfd_firebase/sfd_ecpm.view"
explore: sfd_ecpm {
  group_label: "Attribution"
}

include: "krun_firebase/krun_ecpm.view"
explore: krun_ecpm {
  group_label: "Attribution"
}

include: "sfd_firebase/sfd_power_ltv.view"
explore: sfd_power_ltv {
  group_label: "LTV"
}

include: "sfd_firebase/sfd_power_ltv_attributed.view"
explore: sfd_power_ltv_attributed {
  group_label: "LTV"
}

include: "sfd_firebase/sfd_power_ltv_ab.view"
explore: sfd_power_ltv_ab {
  group_label: "LTV"
}

include: "rh_firebase/rh_power_ltv.view"
explore: rh_power_ltv {
  group_label: "LTV"
}
include: "rh_firebase/rh_power_ltv_attributed.view"
explore: rh_power_ltv_attributed {
  group_label: "LTV"
}

include: "rh_firebase/rh_power_ltv_ab.view"
explore: rh_power_ltv_ab {
  group_label: "LTV"
}

include: "rc_firebase/rc_power_ltv.view"
explore: rc_power_ltv {
  group_label: "LTV"
}

include: "rc_firebase/rc_power_ltv_attributed.view"
explore: rc_power_ltv_attributed {
  group_label: "LTV"
}

include: "rc_firebase/rc_power_ltv_ab.view"
explore: rc_power_ltv_ab {
  group_label: "LTV"
}

include: "mf_firebase/mf_power_ltv.view"
explore: mf_power_ltv {
  group_label: "LTV"
}

include: "mf_firebase/mf_power_ltv_attributed.view"
explore: mf_power_ltv_attributed {
  group_label: "LTV"
}

include: "mf_firebase/mf_power_ltv_ab.view"
explore: mf_power_ltv_ab {
  group_label: "LTV"
}

include: "krun_firebase/krun_power_ltv.view"
explore: krun_power_ltv {
  group_label: "LTV"
}

include: "krun_firebase/krun_power_ltv_attributed.view"
explore: krun_power_ltv_attributed {
  group_label: "LTV"
}

include: "mf_firebase/mf_ecpm.view"
explore: mf_ecpm {
  group_label: "Attribution"
}

include: "rc_firebase/rc_ecpm.view"
explore: rc_ecpm {
  group_label: "Attribution"
}

include: "rh_firebase/rh_max_attribution.view"
explore: rh_max_attribution {
  group_label: "Attribution"
}

include: "/mz_firebase/mz_attribution.view"

explore: mz_attribution {
  label: "mz attribution"
  group_label: "Attribution"
}

# include: "/dq_firebase/firebase_max.view"

# explore: firebase_max {
#   label: "dq max"
#   group_label: "Attribution"

#   join: firebase_max__items {
#     view_label: "Firebase Max: Items"
#     sql: LEFT JOIN UNNEST(${firebase_max.items}) as firebase_max__items ;;
#     relationship: one_to_many
#   }

#   join: firebase_max__event_params {
#     view_label: "Firebase Max: Event Params"
#     sql: LEFT JOIN UNNEST(${firebase_max.event_params}) as firebase_max__event_params ;;
#     relationship: one_to_many
#   }

#   join: firebase_max__user_properties {
#     view_label: "Firebase Max: User Properties"
#     sql: LEFT JOIN UNNEST(${firebase_max.user_properties}) as firebase_max__user_properties ;;
#     relationship: one_to_many
#   }
# }

# include: "/dq_firebase/dq_attribution.view"
# include: "/dq_firebase/dq_events.view"


# explore: dq_attribution {
#   label: "dq attribution"
# }

# explore: dq_events {
#   label: "Drag Queen events"

# ## TO avoid querying the entire database by default, suggest setting up a filter like below, and perhaps limiting GB scanned with 'Max Billing Gigabytes' in the connection
#   always_filter: {
#     filters: {
#       field: event_date
#       value: "last 7 days"
#     }
#   }

#   join: dq_events__event_params {
#     view_label: "Event Properties"
#     sql: LEFT JOIN UNNEST(dq_events.event_params) as dq_events__event_params ;;
#     relationship: one_to_many
#   }

#   join: dq_events__event_params__value {
#     view_label: "Event Properties"
#     sql: LEFT JOIN UNNEST([dq_events__event_params.value]) as dq_events__event_params__value ;;
#     relationship: one_to_many
#   }

#   join: dq_events__user_properties {
#     sql: LEFT JOIN UNNEST(dq_events.user_properties) as dq_events__user_properties ;;
#     view_label: "User Properties"
#     relationship: one_to_many
#   }

#   join: dq_events__user_properties__value {
#     view_label: "User Properties"
#     sql: LEFT JOIN UNNEST([dq_events__user_properties.value]) as dq_events__user_properties__value ;;
#     relationship: one_to_many
#   }

#   join: events {
#     type: inner
#     sql_on: lower(replace(${dq_events.advertising_id},'-',""))=${events.advertising_id};;
#     # --AND LOWER(${dq_events.platform}) = ${events.platform}
#     # --AND ${dq_events.event_date} = ${events.created_date};;
#     relationship: one_to_one
#   }

#   join: campaigns {
#     type: left_outer
#     sql_on: ${events.source_campaign_id} = ${campaigns.id} ;;
#     relationship: one_to_one
#   }

#   join: ad_networks {
#     type: left_outer
#     sql_on: ${campaigns.ad_network_id} = ${ad_networks.id} ;;
#     relationship: one_to_one
#   }

#   join: apps {
#     type: left_outer
#     sql_on: ${campaigns.app_id} = ${apps.id} ;;
#     relationship: one_to_one
#   }

#   join: campaign_buckets {
#     type: left_outer
#     sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
#     relationship: one_to_one
#   }

#   }
