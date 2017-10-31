view: nps_invitations {
  sql_table_name: metta_world_peace.nps_invitations ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: external_customer_id {
    type: number
    sql: ${TABLE}.external_customer_id ;;
  }

  dimension: location_id {
    type: number
    sql: ${TABLE}.location_id ;;
  }

  dimension: phone_number {
    type: string
    sql: ${TABLE}.phone_number ;;
  }

  dimension_group: sent {
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
    sql: ${TABLE}.sent_at ;;
  }

  dimension: sent_via {
    type: string
    sql: ${TABLE}.sent_via ;;
  }

  measure: invites {
    type: count
    drill_fields: [id, customer_name, nps_responses.count]
  }

}
