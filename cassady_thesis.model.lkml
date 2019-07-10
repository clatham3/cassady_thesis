connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"
include: "//cassady_thesis_demographics/*.view"

explore: accidents {
  join: carriers {
    relationship: many_to_one
    sql_on: ${accidents.air_carrier} = ${carriers.name} ;;
  }
  join: airports {
    relationship: many_to_one
    sql_on: ${airports.code} = ${accidents.airport_code} ;;
  }
}

explore: aircraft {}

explore: aircraft_models {}

explore: airports {}

explore: bruce_mv {}

explore: bruce_mv2 {}

explore: cal454 {}

explore: carriers {}

explore: flights {
  join: airports {
    relationship: many_to_one
    sql_on: ${airports.code} = ${flights.origin} ;;
  }
  join: carriers {
    relationship: many_to_one
    sql_on: ${carriers.code} = ${flights.carrier} ;;
  }
}

explore: flights_by_day {}
