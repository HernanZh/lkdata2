view: playtime_per_day {
  derived_table: {
    sql: select  platform,
        bundle_id,
        avg(D1_playtime_mins) as AVG_D1_mins,
        avg(D2_playtime_mins) as AVG_D2_mins,
        avg(D3_playtime_mins) as AVG_D3_mins,
        avg(D4_playtime_mins) as AVG_D4_mins,
        avg(D5_playtime_mins) as AVG_D5_mins,
        avg(D6_playtime_mins) as AVG_D6_mins,
        avg(D7_playtime_mins) as AVG_D7_mins,
from(
    select  idfa,
            user_id,
            platform,
            bundle_id,
            sum(day1_login_hours)/60 as D1_playtime_mins,
            sum(day2_login_hours)/60 as D2_playtime_mins,
            sum(day3_login_hours)/60 as D3_playtime_mins,
            sum(day4_login_hours)/60 as D4_playtime_mins,
            sum(day5_login_hours)/60 as D5_playtime_mins,
            sum(day6_login_hours)/60 as D6_playtime_mins,
            sum(day7_login_hours)/60 as D7_playtime_mins
    from(
        select
          idfa,
          user_id,
          days_since_install,
          platform,
          bundle_id,
          coalesce(sum(CASE WHEN days_since_install = 0 THEN playtime ELSE 0 END),0) AS day1_login_hours,
          coalesce(sum(CASE WHEN days_since_install = 1 THEN playtime ELSE 0 END),0) AS day2_login_hours,
          coalesce(sum(CASE WHEN days_since_install = 2 THEN playtime ELSE 0 END),0) AS day3_login_hours,
          coalesce(sum(CASE WHEN days_since_install = 3 THEN playtime ELSE 0 END),0) AS day4_login_hours,
          coalesce(sum(CASE WHEN days_since_install = 4 THEN playtime ELSE 0 END),0) AS day5_login_hours,
          coalesce(sum(CASE WHEN days_since_install = 5 THEN playtime ELSE 0 END),0) AS day6_login_hours,
          coalesce(sum(CASE WHEN days_since_install = 6 THEN playtime ELSE 0 END),0) AS day7_login_hours,
          --coalesce(sum(CASE WHEN days_since_install = 7 THEN playtime ELSE 0 END),0) AS day7_login_hours
        from(
            SELECT
              --CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS DATE) AS install_date,
              game_analytics.ios_idfa  AS idfa,
              game_analytics.user_id  AS user_id,
              game_analytics.platform AS platform,
              game_analytics.bundle_id as bundle_id,
                CAST(TIMESTAMP_DIFF((TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.arrival_ts)  AS TIMESTAMP), DAY)) , (TIMESTAMP_TRUNC(CAST(TIMESTAMP_SECONDS(game_analytics.install_ts)  AS TIMESTAMP), DAY)) , DAY) AS INT64) AS days_since_install,
              (COUNT(DISTINCT game_analytics.session_id )) * (AVG(game_analytics.length )) / (COUNT(DISTINCT game_analytics.user_id ))  AS playtime

            FROM game_analytics.data_export_new  AS game_analytics
            WHERE (((TIMESTAMP_SECONDS(game_analytics.install_ts) ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -13 DAY)))
              AND (TIMESTAMP_SECONDS(game_analytics.install_ts) ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -13 DAY), INTERVAL 14 DAY)))))
              AND (game_analytics.bundle_id = 'com.gezellig.roadcrash')
              --AND (game_analytics.platform = 'ios')
              --AND (game_analytics.ios_idfa = 'A32EEF43-917C-486C-AA2E-4E3C09D5B315')
              AND bundle_id is not null
            GROUP BY 1,2,3,4,5
            ORDER BY 1 DESC
        )
        group by 1,2,3,4,5
    )
    group by 1,2,3,4
)
group by 1,2
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }

  dimension: avg_d1_mins {
    type: number
    sql: ${TABLE}.AVG_D1_mins ;;
  }

  dimension: avg_d2_mins {
    type: number
    sql: ${TABLE}.AVG_D2_mins ;;
  }

  dimension: avg_d3_mins {
    type: number
    sql: ${TABLE}.AVG_D3_mins ;;
  }

  dimension: avg_d4_mins {
    type: number
    sql: ${TABLE}.AVG_D4_mins ;;
  }

  dimension: avg_d5_mins {
    type: number
    sql: ${TABLE}.AVG_D5_mins ;;
  }

  dimension: avg_d6_mins {
    type: number
    sql: ${TABLE}.AVG_D6_mins ;;
  }

  dimension: avg_d7_mins {
    type: number
    sql: ${TABLE}.AVG_D7_mins ;;
  }

  set: detail {
    fields: [
      platform,
      bundle_id,
      avg_d1_mins,
      avg_d2_mins,
      avg_d3_mins,
      avg_d4_mins,
      avg_d5_mins,
      avg_d6_mins,
      avg_d7_mins
    ]
  }
}
