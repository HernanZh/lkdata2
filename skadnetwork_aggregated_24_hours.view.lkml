view: skadnetwork_aggregated_24_hours {
  derived_table: {
    sql: select
      created_date,
      sum(conversion_value)/1000 as raw_revenue
      from(
          select
          created_date,
          advertising_id,
          max(conversion_value) as conversion_value
          --For each day get the date and revenue of the highest value
          from(
              SELECT
              DATE(events.created_at) as created_date,
              DATEPART(hour,events.created_at) AS OnHour,
              events.advertising_id  AS advertising_id,
              events.value as conversion_value,
              COUNT(*) AS totals
              FROM tenjin.events  AS events
              WHERE (events.event = 'skadnetwork4-totalrevenue')
                AND (events.bundle_id = 'com.gezellig.savethedate')
                AND (events.platform ='ios')
                AND events.advertising_id is not null
                --Check in timestamps of last 24 hours
                --AND advertising_id = 'fe423572f36844a8ab9e096acd1177c6'
                AND events.created_at between dateadd(hour, -24,events.created_at ) and events.created_at
              GROUP BY 1,2,3,4
          )
          group by 1,2
      )
      group by 1
      order by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: created_date {
    type: date
    sql: ${TABLE}.created_date ;;
  }

  dimension: raw_revenue {
    type: number
    sql: ${TABLE}.raw_revenue ;;
  }

  set: detail {
    fields: [created_date, raw_revenue]
  }
}
