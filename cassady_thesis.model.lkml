connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"
include: "//cassady_thesis_demographics/*.view"

explore: accidents {
  join: aircraft_models {
    relationship: many_to_one
    sql_on: ${accidents.make} = ${aircraft_models.manufacturer} ;;
  }
#   join: aircraft {
#     relationship: many_to_one
#     sql_on: ${aircraft_models.aircraft_model_code} = ${aircraft.aircraft_model_code};;
#   }
#   join: carriers {
#     relationship: many_to_one
#     sql_on: ${accidents.air_carrier} = ${carriers.code} ;;
#   }
#   join: airports {
#     relationship: many_to_one
#     sql_on: ${airports.code} = ${accidents.airport_code} ;;
#   }
#   join: flights {
#     relationship: many_to_one
#     sql_on: ${flights.origin} = ${accidents.airport_code} ;;
#   }
}

explore: aircraft {}

explore: aircraft_models {}

explore: airports {
  join: bq_logrecno_bg_map {
    relationship: many_to_many
    sql_on: ${airports.state} = ${bq_logrecno_bg_map.stusab};;
  }
}

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

explore: Cancelled_Flights {}
