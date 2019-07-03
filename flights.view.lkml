view: flights {
  sql_table_name: faa.flights ;;

  dimension: arr_delay {
    type: number
    sql: ${TABLE}.arr_delay ;;
  }

  dimension_group: arr {
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
    sql: ${TABLE}.arr_time ;;
  }

  dimension: cancelled {
    type: string
    sql: ${TABLE}.cancelled ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: dep_delay {
    type: number
    sql: ${TABLE}.dep_delay ;;
  }

  dimension_group: dep {
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
    sql: ${TABLE}.dep_time ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
  }

  dimension: diverted {
    type: string
    sql: ${TABLE}.diverted ;;
  }

  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
  }

  dimension: flight_time {
    type: number
    sql: ${TABLE}.flight_time ;;
  }

  dimension: id2 {
    type: number
    sql: ${TABLE}.id2 ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: tail_num {
    type: string
    sql: ${TABLE}.tail_num ;;
  }

  dimension: taxi_in {
    type: number
    sql: ${TABLE}.taxi_in ;;
  }

  dimension: taxi_out {
    type: number
    sql: ${TABLE}.taxi_out ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: flights_cancelled_by_airport_and_carrier {
  derived_table: {
    explore_source: flights {
      column: full_name { field: airports.full_name }
      column: cancelled {}
      column: count {}
      filters: {
        field: flights.cancelled
        value: "N"
      }
      filters: {
        field: airports.full_name
        value: "-EMPTY"
      }
    }
  }
  dimension: full_name {}
  dimension: cancelled {}
  dimension: count {
    type: number
  }
}

view: flights_not_cancelled_by_airport_and_carrier {
  derived_table: {
    explore_source: flights {
      column: full_name { field: airports.full_name }
      column: cancelled {}
      column: count {}
      filters: {
        field: flights.cancelled
        value: "Y"
      }
      filters: {
        field: airports.full_name
        value: "-EMPTY"
      }
    }
  }
  dimension: full_name {}
  dimension: cancelled {}
  dimension: count {
    type: number
  }
}
