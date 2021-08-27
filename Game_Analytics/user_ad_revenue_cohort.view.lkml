view: user_ad_revenue_cohort {
  derived_table: {
    sql: select user_id,platform,first_date_created,date_created,day_cohort,
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
      sum(case when day_cohort=30 then revenue else 0 end) as Rev_30

      from

      (select a.*,b.first_date_created, date_diff(a.date_created,b.first_date_created,DAY) as day_cohort from
      (SELECT
        user_ad_revenue.user_id  AS user_id,
        user_ad_revenue.platform  AS platform,
        CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS date_created,
        COALESCE(SUM(user_ad_revenue.revenue ), 0) AS revenue
      FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
      GROUP BY 1,2,3) as a
      left join
      (SELECT
        user_ad_revenue.user_id  AS user_id,
        min(CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE)) AS first_date_created
        FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
      GROUP BY 1) as b
      on a.user_id=b.user_id)c

      group by 1,2,3,4,5
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

  dimension: first_date_created {
    type: date
    sql: ${TABLE}.first_date_created ;;
  }

  dimension: date_created {
    type: date
    sql: ${TABLE}.date_created ;;
  }

  dimension: day_cohort {
    type: number
    sql: ${TABLE}.day_cohort ;;
  }

  dimension: rev_0 {
    type: number
    sql: ${TABLE}.Rev_0 ;;
  }

  dimension: rev_1 {
    type: number
    sql: ${TABLE}.Rev_1 ;;
  }

  dimension: rev_2 {
    type: number
    sql: ${TABLE}.Rev_2 ;;
  }

  dimension: rev_3 {
    type: number
    sql: ${TABLE}.Rev_3 ;;
  }

  dimension: rev_4 {
    type: number
    sql: ${TABLE}.Rev_4 ;;
  }

  dimension: rev_5 {
    type: number
    sql: ${TABLE}.Rev_5 ;;
  }

  dimension: rev_6 {
    type: number
    sql: ${TABLE}.Rev_6 ;;
  }

  dimension: rev_7 {
    type: number
    sql: ${TABLE}.Rev_7 ;;
  }

  dimension: rev_8 {
    type: number
    sql: ${TABLE}.Rev_8 ;;
  }

  dimension: rev_9 {
    type: number
    sql: ${TABLE}.Rev_9 ;;
  }

  dimension: rev_10 {
    type: number
    sql: ${TABLE}.Rev_10 ;;
  }

  dimension: rev_11 {
    type: number
    sql: ${TABLE}.Rev_11 ;;
  }

  dimension: rev_12 {
    type: number
    sql: ${TABLE}.Rev_12 ;;
  }

  dimension: rev_13 {
    type: number
    sql: ${TABLE}.Rev_13 ;;
  }

  dimension: rev_14 {
    type: number
    sql: ${TABLE}.Rev_14 ;;
  }

  dimension: rev_15 {
    type: number
    sql: ${TABLE}.Rev_15 ;;
  }

  dimension: rev_16 {
    type: number
    sql: ${TABLE}.Rev_16 ;;
  }

  dimension: rev_17 {
    type: number
    sql: ${TABLE}.Rev_17 ;;
  }

  dimension: rev_18 {
    type: number
    sql: ${TABLE}.Rev_18 ;;
  }

  dimension: rev_19 {
    type: number
    sql: ${TABLE}.Rev_19 ;;
  }

  dimension: rev_20 {
    type: number
    sql: ${TABLE}.Rev_20 ;;
  }

  dimension: rev_21 {
    type: number
    sql: ${TABLE}.Rev_21 ;;
  }

  dimension: rev_22 {
    type: number
    sql: ${TABLE}.Rev_22 ;;
  }

  dimension: rev_23 {
    type: number
    sql: ${TABLE}.Rev_23 ;;
  }

  dimension: rev_24 {
    type: number
    sql: ${TABLE}.Rev_24 ;;
  }

  dimension: rev_25 {
    type: number
    sql: ${TABLE}.Rev_25 ;;
  }

  dimension: rev_26 {
    type: number
    sql: ${TABLE}.Rev_26 ;;
  }

  dimension: rev_27 {
    type: number
    sql: ${TABLE}.Rev_27 ;;
  }

  dimension: rev_28 {
    type: number
    sql: ${TABLE}.Rev_28 ;;
  }

  dimension: rev_29 {
    type: number
    sql: ${TABLE}.Rev_29 ;;
  }

  dimension: rev_30 {
    type: number
    sql: ${TABLE}.Rev_30 ;;
  }

  set: detail {
    fields: [
      user_id,
      platform,
      first_date_created,
      date_created,
      day_cohort,
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
      rev_30
    ]
  }
  }
