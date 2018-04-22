$(document).on 'turbolinks:load', ->
  return unless $('#chart_data').length > 0
  new Highcharts.Chart(
    chart:
      renderTo: "orders_chart"
    title:
      text: "Statistic orders"
    xAxis:
      type: "datetime"
    yAxis:
      title:
        text: "Dollars"
    tooltip:
      text: Highcharts.dateFormat("%B %e %Y", this.x) + ': ' + '$' + Highcharts.numberFormat(this.y, 2)
    series: $('#chart_data').data('temp')
  )
