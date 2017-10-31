view: nps_responses {
  sql_table_name: metta_world_peace.nps_responses ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension_group: received {
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
    sql: ${TABLE}.inserted_at ;;
  }

  dimension: response {
    type: number
    sql: ${TABLE}.ltr ;;
  }

  dimension: nps_invitation_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.nps_invitation_id ;;
  }

  dimension: nps_bucket {
    type: string
    sql: CASE WHEN ${response} >= 9 THEN 'Promoter' WHEN ${response} <= 6 THEN 'Detractor' ELSE 'Passive' END ;;
  }

  measure: promoters {
    type: count
    filters: {
      field: response
      value: ">= 9"
    }
  }

  measure: responses {
    type: count
    drill_fields: [id, nps_invitations.id, nps_invitations.customer_name]
  }

  measure: detractors {
    type: count
    filters: {
      field: response
      value: "<= 6"
    }
  }

  measure: nps {
    type: number
    sql: 100 * (${promoters} - ${detractors}) / ${responses} ;;
  }
}
