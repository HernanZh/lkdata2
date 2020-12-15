view: uar_cohort_test {
  derived_table: {
    sql: select date_created,
      --first_date_created,
      platform,
      c.bundle_id,
      day_cohort,
      sum(case when day_cohort<=0 then revenue else 0 end) as revenue_d1,
      sum(case when day_cohort<=1 then revenue else 0 end) as revenue_d2,
      sum(case when day_cohort<=2 then revenue else 0 end) as revenue_d3,
      sum(case when day_cohort<=3 then revenue else 0 end) as revenue_d4,
      sum(case when day_cohort<=4 then revenue else 0 end) as revenue_d5,
      sum(case when day_cohort<=5 then revenue else 0 end) as revenue_d6,
      sum(case when day_cohort<=6 then revenue else 0 end) as revenue_d7,
      sum(case when day_cohort<=13 then revenue else 0 end) as revenue_d14,
      sum(case when day_cohort<=20 then revenue else 0 end) as revenue_d21,
      sum(case when day_cohort<=29 then revenue else 0 end) as revenue_d30,
      sum(case when day_cohort<=59 then revenue else 0 end) as revenue_d60,
      sum(case when day_cohort<=99 then revenue else 0 end) as revenue_d90,
      sum(when day_cohort<=0 THEN 1 END) as tracked_installs

      from
      (select a.*,b.first_date_created,
      date_diff(a.date_created,b.first_date_created,DAY) as day_cohort
      from
          (SELECT
            user_ad_revenue.user_id  AS user_id,
            user_ad_revenue.platform  AS platform,
            user_ad_revenue.bundle_id as bundle_id,
            CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE) AS date_created,
            COALESCE(SUM(user_ad_revenue.revenue ), 0) AS revenue
      FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
      GROUP BY 1,2,3,4) as a
      left join
          (SELECT
            user_ad_revenue.user_id  AS user_id,
            user_ad_revenue.platform  AS platform,
            user_ad_revenue.bundle_id as bundle_id,
            min(CAST(CAST(user_ad_revenue.date_created  AS TIMESTAMP) AS DATE)) AS first_date_created
            FROM tenjin_BigQuery.user_ad_revenue  AS user_ad_revenue
          GROUP BY 1,2,3) as b
      on a.user_id=b.user_id
      and a.platform = b.platform
      and a.bundle_id = b.bundle_id)c
      group by 1,2,3,4
      order by 1 DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date_created {
    type: date
    datatype: date
    sql: ${TABLE}.date_created ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: day_cohort {
    type: number
    sql: ${TABLE}.day_cohort ;;
  }

  measure: revenue_d1 {
    type: sum
    sql: ${TABLE}.revenue_d1 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d2 {
    type: sum
    sql: ${TABLE}.revenue_d2 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d3 {
    type: sum
    sql: ${TABLE}.revenue_d3 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d4 {
    type: sum
    sql: ${TABLE}.revenue_d4 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d5 {
    type: sum
    sql: ${TABLE}.revenue_d5 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d6 {
    type: sum
    sql: ${TABLE}.revenue_d6 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d7 {
    type: sum
    sql: ${TABLE}.revenue_d7 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d14 {
    type: sum
    sql: ${TABLE}.revenue_d14 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d21 {
    type: sum
    sql: ${TABLE}.revenue_d21 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d30 {
    type: sum
    sql: ${TABLE}.revenue_d30 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d60 {
    type: sum
    sql: ${TABLE}.revenue_d60 ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_d90 {
    type: sum
    sql: ${TABLE}.revenue_d90 ;;
    value_format: "$#,##0.00"
  }

  measure: first_day_users {
    type: sum
    sql: ${TABLE}.tracked_installs;;
  }


  set: detail {
    fields: [
      date_created,
      platform,
      bundle_id,
      day_cohort,
      revenue_d1,
      revenue_d2,
      revenue_d3,
      revenue_d4,
      revenue_d5,
      revenue_d6,
      revenue_d7,
      revenue_d14,
      revenue_d21,
      revenue_d30,
      revenue_d60,
      revenue_d90,
      first_day_users

    ]
  }
}
