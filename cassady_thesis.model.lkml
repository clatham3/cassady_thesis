connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: cassady_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cassady_thesis_default_datagroup

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

explore: airports {}

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
