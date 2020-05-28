view: user_cohorts {
    derived_table: {
      sql: select user_id,platform,bundle_id,country,acquired_date,campaign_id,

                                  sum(case when day_cohort=0 then revenue else 0 end) as Rev_0,
                                  sum(case when day_cohort=1 then revenue else 0 end) as Rev_1,
                                  sum(case when day_cohort=2 then revenue else 0 end) as Rev_2,
                                  sum(case when day_cohort=3 then revenue else 0 end) as Rev_3,
                                  sum(case when day_cohort=4 then revenue else 0 end) as Rev_4,
                                  sum(case when day_cohort=5 then revenue else 0 end) as Rev_5,
                                  sum(case when day_cohort=6 then revenue else 0 end) as Rev_6,
                                  sum(case when day_cohort=7 then revenue else 0 end) as Rev_7,
                                  sum(case when day_cohort=8 then revenue else 0 end) as Rev_8,
                                  sum(case when day_cohort=9 then revenue else 0 end) as Rev_9,
                                  sum(case when day_cohort=10 then revenue else 0 end) as Rev_10,
                                  sum(case when day_cohort=11 then revenue else 0 end) as Rev_11,
                                  sum(case when day_cohort=12 then revenue else 0 end) as Rev_12,
                                  sum(case when day_cohort=13 then revenue else 0 end) as Rev_13,
                                  sum(case when day_cohort=14 then revenue else 0 end) as Rev_14,
                                  sum(case when day_cohort=15 then revenue else 0 end) as Rev_15,
                                  sum(case when day_cohort=16 then revenue else 0 end) as Rev_16,
                                  sum(case when day_cohort=17 then revenue else 0 end) as Rev_17,
                                  sum(case when day_cohort=18 then revenue else 0 end) as Rev_18,
                                  sum(case when day_cohort=19 then revenue else 0 end) as Rev_19,
                                  sum(case when day_cohort=20 then revenue else 0 end) as Rev_20,
                                  sum(case when day_cohort=21 then revenue else 0 end) as Rev_21,
                                  sum(case when day_cohort=22 then revenue else 0 end) as Rev_22,
                                  sum(case when day_cohort=23 then revenue else 0 end) as Rev_23,
                                  sum(case when day_cohort=24 then revenue else 0 end) as Rev_24,
                                  sum(case when day_cohort=25 then revenue else 0 end) as Rev_25,
                                  sum(case when day_cohort=26 then revenue else 0 end) as Rev_26,
                                  sum(case when day_cohort=27 then revenue else 0 end) as Rev_27,
                                  sum(case when day_cohort=28 then revenue else 0 end) as Rev_28,
                                  sum(case when day_cohort=29 then revenue else 0 end) as Rev_29,
                                  sum(case when day_cohort=30 then revenue else 0 end) as Rev_30,
                                  sum(case when day_cohort>30 then revenue else 0 end) as Rev_more_than_30,
                                  sum(case when day_cohort<0 then revenue else 0 end) as Rev_less_than_0

                    from
                    (select user_ad_revenue.*,user_attributes.*, date_diff(user_ad_revenue.date_created,user_attributes.acquired_date,DAY) as day_cohort from
                                  (SELECT
                                    user_ad_revenue.user_id  AS user_id,
                                    user_ad_revenue.platform  AS platform,
                                    CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS date_created,
                                    user_ad_revenue.bundle_id  AS bundle_id,
                                    user_ad_revenue.advertising_id,
                                    COALESCE(SUM(user_ad_revenue.revenue ), 0) AS revenue
                                  FROM tenjin_BigQuery.user_ad_revenue
                                  group by 1,2,3,4,5)AS user_ad_revenue

                              LEFT JOIN

                              (select CAST(rs_user_attributes.acquired_at  AS DATE) AS acquired_date,
                                 rs_user_attributes.country  AS country,
                                 rs_user_attributes.campaign_id  AS campaign_id,
                                 rs_user_attributes.advertising_id,
                                 rs_user_attributes.developer_device_id from
                              tenjin_BigQuery.rs_user_attributes ) AS user_attributes
                              ON (COALESCE(user_attributes.advertising_id, user_attributes.developer_device_id)) = user_ad_revenue.advertising_id) c


              group by 1,2,3,4,5,6
               ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: user_id {
      type: string
      sql: ${TABLE}.user_id ;;
    }

    dimension: platform {
      type: string
      sql: ${TABLE}.platform ;;
    }

    dimension: bundle_id {
      type: string
      sql: ${TABLE}.bundle_id ;;
    }

    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
    }

    dimension: acquired_date {
      type: date
      sql: ${TABLE}.acquired_date ;;
    }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

   measure: rev_0 {
      type: sum
      sql: ${TABLE}.Rev_0 ;;
    }

    measure: rev_1 {
      type: sum
      sql: ${TABLE}.Rev_1 ;;
    }

    measure: rev_2 {
      type: sum
      sql: ${TABLE}.Rev_2 ;;
    }

    measure: rev_3 {
      type: sum
      sql: ${TABLE}.Rev_3 ;;
    }

    measure: rev_4 {
      type: sum
      sql: ${TABLE}.Rev_4 ;;
    }

    measure: rev_5 {
      type: sum
      sql: ${TABLE}.Rev_5 ;;
    }

    measure: rev_6 {
      type: sum
      sql: ${TABLE}.Rev_6 ;;
    }

    measure: rev_7 {
      type: sum
      sql: ${TABLE}.Rev_7 ;;
    }

    measure: rev_8 {
      type: number
      sql: ${TABLE}.Rev_8 ;;
    }

    measure: rev_9 {
      type: sum
      sql: ${TABLE}.Rev_9 ;;
    }

    measure: rev_10 {
      type: sum
      sql: ${TABLE}.Rev_10 ;;
    }

    measure: rev_11 {
      type: sum
      sql: ${TABLE}.Rev_11 ;;
    }

    measure: rev_12 {
      type: sum
      sql: ${TABLE}.Rev_12 ;;
    }

    measure: rev_13 {
      type: sum
      sql: ${TABLE}.Rev_13 ;;
    }

    measure: rev_14 {
      type: sum
      sql: ${TABLE}.Rev_14 ;;
    }

    measure: rev_15 {
      type: sum
      sql: ${TABLE}.Rev_15 ;;
    }

    measure: rev_16 {
      type: sum
      sql: ${TABLE}.Rev_16 ;;
    }

    measure: rev_17 {
      type: sum
      sql: ${TABLE}.Rev_17 ;;
    }

    measure: rev_18 {
      type: sum
      sql: ${TABLE}.Rev_18 ;;
    }

    measure: rev_19 {
      type: sum
      sql: ${TABLE}.Rev_19 ;;
    }

    measure: rev_20 {
      type: sum
      sql: ${TABLE}.Rev_20 ;;
    }

    measure: rev_21 {
      type: sum
      sql: ${TABLE}.Rev_21 ;;
    }

    measure: rev_22 {
      type: sum
      sql: ${TABLE}.Rev_22 ;;
    }

    measure: rev_23 {
      type: sum
      sql: ${TABLE}.Rev_23 ;;
    }

    measure: rev_24 {
      type: sum
      sql: ${TABLE}.Rev_24 ;;
    }

    measure: rev_25 {
      type: sum
      sql: ${TABLE}.Rev_25 ;;
    }

    measure: rev_26 {
      type: sum
      sql: ${TABLE}.Rev_26 ;;
    }

    measure: rev_27 {
      type: sum
      sql: ${TABLE}.Rev_27 ;;
    }

    measure: rev_28 {
      type: sum
      sql: ${TABLE}.Rev_28 ;;
    }

    measure: rev_29 {
      type: sum
      sql: ${TABLE}.Rev_29 ;;
    }

    measure: rev_30 {
      type: sum
      sql: ${TABLE}.Rev_30 ;;
    }

    measure: rev_more_than_30 {
      type: sum
      sql: ${TABLE}.Rev_more_than_30 ;;
    }

    measure: rev_less_than_0 {
      type: sum
      sql: ${TABLE}.Rev_less_than_0 ;;
    }

    set: detail {
      fields: [
        user_id,
        platform,
        bundle_id,
        country,
        acquired_date,
        rev_0,
        rev_1,
        rev_2,
        rev_3,
        rev_4,
        rev_5,
        rev_6,
        rev_7,
        rev_8,
        rev_9,
        rev_10,
        rev_11,
        rev_12,
        rev_13,
        rev_14,
        rev_15,
        rev_16,
        rev_17,
        rev_18,
        rev_19,
        rev_20,
        rev_21,
        rev_22,
        rev_23,
        rev_24,
        rev_25,
        rev_26,
        rev_27,
        rev_28,
        rev_29,
        rev_30,
        rev_more_than_30,
        rev_less_than_0
      ]
    }
  }
