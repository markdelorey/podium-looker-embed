view: reviews {
  sql_table_name: review_rocket.third_party_reviews ;;

  dimension: third_party_review_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.third_party_review_id ;;
  }

  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
  }

  dimension: author_id {
    type: string
    sql: ${TABLE}.author_id ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: location_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.location_id ;;
  }

  dimension_group: published {
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
    sql: ${TABLE}.publish_date ;;
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
  }

  dimension: review_body {
    type: string
    sql: ${TABLE}.review_body ;;
  }

  dimension: review_invitation_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.review_invitation_id ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.site_name ;;
  }

  dimension_group: reporting_date {
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
    sql: CASE WHEN ${TABLE}.review_invitation_id IS NULL ${TABLE}.publish_date ELSE review_invitations.sent_at END ;;
}

  measure: average_rating {
    type: average
    sql: ${rating} ;;
  }

  measure: review_count {
    type: count_distinct
    sql: ${third_party_review_id} ;;
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      third_party_review_id,
      site_name,
      review_invitations.id,
      review_invitations.customer_name,
      locations.id,
      locations.name
    ]
  }
}
