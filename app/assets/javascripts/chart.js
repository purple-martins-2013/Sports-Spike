var Chart = {
  init: function() {
    $.get('redis_trips/render_data', this.renderChart);
  },

  renderChart: function(data) {
    new Highcharts.Chart({
      chart: {
          renderTo: 'chart'
      },
      xAxis: {
          type: 'datetime'
      },
      series: [{
          data: data}]
    });
  }
}

$(document).ready(function() {
  Chart.init();
})
