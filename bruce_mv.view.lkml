view: bruce_mv {
  sql_table_name: faa.bruce_mv ;;

  dimension: airport_name {
    type: string
    sql: ${TABLE}.airport_name ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension: weather_condition {
    type: string
    sql: ${TABLE}.weather_condition ;;
  }

  measure: count {
    type: count
    drill_fields: [airport_name]
  }
}
