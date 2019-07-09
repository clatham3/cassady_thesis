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

  measure: Not_Cancelled {
    type: count
    filters: {
      field: cancelled
      value: "N"
    }
    drill_fields: [carriers.name, Dep_Delayed, Dep_Not_Delayed]
  }
  measure: Flights_Cancelled {
    type: count
    filters: {
      field: cancelled
      value: "Y"
    }
    drill_fields: [carriers.name, count, arr_quarter]
  }

  measure: Cancelled_Carrier {
    type: count
    filters: {
      field:  cancelled
      value: "Y"
    }
    drill_fields: [airports.full_name, count, arr_quarter]
  }

  measure: Not_Cancelled_Carrier {
    type:  count
    filters: {
      field: cancelled
      value: "N"
    }
    drill_fields: [airports.full_name, Dep_Delayed, Dep_Not_Delayed]
  }

  measure: Dep_Delayed {
    type: count
    filters: {
      field: dep_delay
      value: "> 0"
    }
    drill_fields: [carriers.name, dep_quarter, count]
  }
  measure: Dep_Not_Delayed {
    type: count
    filters: {
      field: dep_delay
      value: "<= 0"
    }
    drill_fields: [carriers.name, dep_quarter, count]
  }

  measure: Arr_Delayed {
    type: count
    filters: {
      field: arr_delay
      value: "> 0"
    }
    drill_fields: [diverted, count, airports.full_name]
  }
  measure: Arr_Not_Delayed {
    type: count
    filters: {
      field: arr_delay
      value: "<= 0"
    }
  }
}

view: Cancelled_Flights {
  derived_table: {
    sql: SELECT
           airports.full_name  AS airports_name,
           FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP_TRUNC(CAST(flights.arr_time  AS TIMESTAMP), QUARTER)) AS arrival_quarter,
           COUNT(CASE WHEN (flights.cancelled = 'Y') THEN 1 ELSE NULL END) AS cancelled_flights,
           COUNT(flights.flight_num) AS total_flights
         FROM faa.flights  AS flights
        LEFT JOIN faa.airports  AS airports ON airports.code = flights.origin
        GROUP BY 2,1
        ORDER BY 2 DESC
        LIMIT 500;;

  }
  dimension: arrival_quarter {}
  dimension: airports_name {}
  dimension: cancelled_flights {
    type: number
  }
  dimension: total_flights {
    type: number
  }
}
