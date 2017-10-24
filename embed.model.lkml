connection: "redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: locations {
  access_filter: {
    field: organization_id
    user_attribute: organization_id
  }
}

explore: review_invitations {
  access_filter: {
    field: locations.organization_id
    user_attribute: organization_id
  }
  join: users {
    sql_on:  ${review_invitations.user_id} = ${users.id};;
    relationship: one_to_one
    type: left_outer
  }
  join: third_party_reviews {
    sql_on: ${third_party_reviews.review_invitation_id} = ${review_invitations.id};;
    relationship: one_to_one
    type:  full_outer
  }
  join: locations {
    sql_on: CASE WHEN ${review_invitations.id} IS NULL THEN ${third_party_reviews.location_id} = ${locations.id} ELSE ${review_invitations.location_id} = ${locations.id} END ;;
    relationship:  many_to_one
    type: left_outer
  }
}
