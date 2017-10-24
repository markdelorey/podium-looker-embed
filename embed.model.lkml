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
