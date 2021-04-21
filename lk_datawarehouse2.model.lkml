#connection: "lk-datawarehouse"
connection: "lk-datawarehouse-2"

# include all the views
include: "*.view"

datagroup: lk_datawarehouse2_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "12 hours"
}

persist_with: lk_datawarehouse2_default_datagroup

explore: d_conversionValue {}

# explore: SKAdNetwork_Test {}

explore: user_ad_revenue_old {
  join: events {
    type: left_outer
    sql_on: ${events.advertising_id} = ${user_ad_revenue_old.advertising_id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${events.source_campaign_id} = ${campaigns.id} ;;
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

explore: GA_business {
  # join: GA_session_end {
  #   type: left_outer
  #   sql_on: ${GA_business.ios_idfa}=${GA_session_end.ios_idfa} AND
  #           ${GA_business.ios_idfv}=${GA_session_end.ios_idfv} AND
  #           ${GA_business.user_id}=${GA_session_end.user_id} AND
  #           ${GA_business.ios_bundle_id}=${GA_session_end.ios_bundle_id} AND
  #           ${GA_business.android_bundle_id}=${GA_session_end.android_bundle_id} AND
  #           ${GA_business.client_ts}=${GA_session_end.client_ts} AND
  #           ${GA_business.platform}=${GA_session_end.platform} AND
  #           ${GA_business.install_ts_date}=${GA_session_end.install_ts_date}
  #           ;;
  #   fields: [game_id,length, playtime,avg_session_length]
  #   relationship: many_to_one
  # }
}
explore: GA_design{}
explore: GA_error {}
explore: GA_progression {}
explore: GA_resource {}
explore: GA_sdk_error {}
explore: GA_session_end {}
explore: GA_session_end_new {}
explore: ga_session_end_raw {}
explore: GA_user{}
explore: ga_minimalistic {}
explore: ga_ilrd {}
explore: ga_ilrd_cohorts {}

#explore: auditlog_ga {}

#explore:  attribution_table{}

explore: ga_uar_testing {}

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
    sql_on: ${reporting_cohorted_revenue.ad_network_id} = ${reporting_metrics.ad_network_id} AND
          ${reporting_cohorted_revenue.app_id} = ${reporting_metrics.app_id} AND
          ${reporting_cohorted_revenue.campaign_id} = ${reporting_metrics.campaign_id} AND
          ${reporting_cohorted_revenue.site_id} = ${reporting_metrics.site_id} AND
          ${reporting_cohorted_revenue.country} = ${reporting_metrics.country} AND
          ${reporting_cohorted_revenue.date} = ${reporting_metrics.date_date} AND
          ${reporting_cohorted_revenue.platform} = ${reporting_metrics.platform}
          ;;
    relationship: many_to_one
  }

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

# explore: cohort_behavior {
#   join: campaigns {
#     type: left_outer
#     sql_on: ${cohort_behavior.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }

#   join: campaign_buckets {
#     type: left_outer
#     sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
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

  # join: ltv_predict{
  #   type: left_outer
  #   sql_on: ${cohort_behavior.xday} = ${ltv_predict.xday} ;;
  #   relationship: many_to_one
  # }
# }

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

# explore: daily_behavior {
#   join: campaigns {
#     type: left_outer
#     sql_on: ${daily_behavior.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }

#   join: campaign_buckets {
#     type: left_outer
#     sql_on: ${campaigns.campaign_bucket_id} = ${campaign_buckets.id} ;;
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

#   join: events {
#     type: left_outer
#     sql_on: ${campaigns.id} = ${events.source_campaign_id} ;;
#     relationship: many_to_one
#   }
# }

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
}

explore: game_analytics {
  label: "Game Analytics"
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

explore: impressions {
  # join: games {
  #   type: left_outer
  #   sql_on: ${impressions.game_id} = ${games.id} ;;
  #   relationship: many_to_one
  # }
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

  join: reporting_metrics {
    type: left_outer
    sql_on: ${reporting_cohort_metrics.ad_network_id} = ${reporting_metrics.ad_network_id} AND
          ${reporting_cohort_metrics.app_id} = ${reporting_metrics.app_id} AND
          ${reporting_cohort_metrics.campaign_id} = ${reporting_metrics.campaign_id} AND
          ${reporting_cohort_metrics.site_id} = ${reporting_metrics.site_id} AND
          ${reporting_cohort_metrics.country} = ${reporting_metrics.country} AND
          ${reporting_cohort_metrics.install_date} = ${reporting_metrics.date_date} AND
          ${reporting_cohort_metrics.platform} = ${reporting_metrics.platform}
          ;;
    relationship: many_to_one
  }
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



explore: user_ad_revenue_cohort {}

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

explore: user_ad_revenue {
  join: events {
    type: left_outer
    sql_on: ${events.advertising_id} = ${user_ad_revenue.advertising_id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${events.source_campaign_id} = ${campaigns.id} ;;
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

# explore: uar_cohorts {
#   join: user_attributes {
#     type: left_outer
#     sql_on: ${user_attributes.id} = ${uar_cohorts.advertising_id} ;;
#     relationship: many_to_one
#   }

#   join: campaigns {
#     type: left_outer
#     sql_on: ${user_attributes.campaign_id} = ${campaigns.id} ;;
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

#   join: reporting_cohort_metrics {
#     type: left_outer
#     sql_on: ${reporting_cohort_metrics.app_id}=${apps.id} ;;
#     relationship: many_to_one
#   }
# }

explore: user_level_ga_uar_new {}
explore: user_level_ga_uar{}
explore: sk_ad_network_metrics {
  join: apps {
    type: inner
    sql_on: ${apps.id}=${sk_ad_network_metrics.app_id} ;;
    relationship: one_to_one
  }
}
explore: sk_ad_networks {}
# explore: uar_cohort_test {}

# explore: future_revenue_prediction_d3 {}

# explore: future_revenue_prediction_d7 {}

# explore: future_revenue_prediction_d14{}

# explore: future_revenue_prediction_d30 {}
