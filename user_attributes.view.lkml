view: user_attributes {
  sql_table_name: tenjin.user_attributes;;

  dimension_group: acquired {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.acquired_at ;;
  }

  dimension: id {
    type: string
    sql: COALESCE(${TABLE}.advertising_id, ${TABLE}.developer_device_id) ;;
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: country_bucket {
    type: string
    case: {
      when: {
        sql: ${TABLE}.country IN ('AU','CA','DE','NZ','NO','CH', 'GB') ;;
        label: "T1"
      }
      when: {
        sql: ${TABLE}.country IN ('HK','JP','KR','TW') ;;
        label: "T1_LOC"
      }
      when: {
        sql: ${TABLE}.country IN ('AT','BE','DK','FR','NL','SG','SE') ;;
        label: "T2"
      }
      when: {
        sql: ${TABLE}.country IN ('BR','CL','CZ','FI','GR','IS','IN','ID','IE','IL','IT','KW','LU','MX','PH','PL','PT','QA','RU','ZA','ES','TH','TR','UA','AE','VN') ;;
        label: "T3"
      }
      when: {
        sql: ${TABLE}.country IN ('US') ;;
        label: "US"
      }
      when: {
        sql: ${TABLE}.country IN ('CN') ;;
        label: "CN"
      }
      else: "Unknown"
    }
  }

  dimension: developer_device_id {
    type: string
    sql: ${TABLE}.developer_device_id ;;
  }

  dimension_group: last_seen {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_seen ;;
  }

  dimension: limit_ad_tracking {
    type: yesno
    sql: ${TABLE}.limit_ad_tracking = 1 ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  measure: count {
    type: count
    drill_fields: [campaigns.name, campaigns.remote_campaign_id]
  }
}
