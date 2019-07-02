connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"
include: "//cassady_thesis_demographics/*.view"

explore: accidents {
  join: aircraft_models {
    relationship: one_to_many
    sql_on: ${accidents.model} = ${aircraft_models.model} ;;
  }
  join: aircraft {
    relationship: many_to_one
    sql_on: ${aircraft_models.aircraft_model_code} = ${aircraft.aircraft_model_code};;
  }
  join: carriers {
    relationship: many_to_one
    sql_on: ${accidents.air_carrier} = ${carriers.code} ;;
  }
}

explore: aircraft {}

explore: aircraft_models {}

explore: airports {
  join: bq_logrecno_bg_map{
    relationship: many_to_many
    sql_on: ${airports.county} = ${bq_logrecno_bg_map.county};;
  }
}

explore: bruce_mv {}

explore: bruce_mv2 {}

explore: cal454 {}

explore: carriers {}

explore: flights {
  join: carriers {
    relationship: one_to_one
    sql_on: ${flights.carrier} = ${carriers.code} ;;
  }
  join: airports {
    relationship: one_to_many
    sql_on: ${airports.code} = ${flights.origin} ;;
  }
}

explore: flights_by_day {}

explore: flights_dk {}
