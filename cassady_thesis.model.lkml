connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"
include: "//cassady_thesis_weather/*.view"

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
  join: bq_zipcode_facts{
    relationship: one_to_one
    sql_on: ${airports.city} = ${bq_zipcode_facts.city};;
  }
  join: bq_zipcode_station {
    relationship: one_to_one
    sql_on: ${bq_zipcode_facts.zipcode} = ${bq_zipcode_station.zipcode} ;;
  }
  join: bq_gsod {
    relationship: one_to_one
    sql_on: ${bq_zipcode_station.nearest_station_id} = ${bq_gsod.station_id} AND
            ${bq_zipcode_station.year} = ${bq_gsod.year};;
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

explore: flights_dk {}
