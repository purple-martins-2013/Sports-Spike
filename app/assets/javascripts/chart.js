Highcharts.setOptions({
      global: {
        useUTC: false
      }
});


var Chart = {

  pollTime: 60000,

  init: function() {
    this.render();
    this.poll();
    
  },

  poll: function() {
    setInterval(this.render, this.pollTime)
  },

  render: function() {
    $.get('redis_trips/render_data', function(data) {
      var newData = [];
      var data = $.each(data, function(k, coordinate) {
        newData.push([Date.parse(coordinate[0]), coordinate[1]]);
      });
      Chart.draw(newData);
    });
  },

  draw: function(data) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'chart'
      },

      title: {
        text: 'The Pulse of Patriots Nation'
      },
      navigator: {
        enabled: true,
        adaptToUpdatedData: true

      },

      legend: {
        enabled: false
      },
      xAxis: {
          type: 'datetime',
          dateTimeLabelFormats: {
            minute: '%d<br/>%H:%M',
            hour: '%d<br/>%H:%M',
            day: '%m-%d',
            week: '%m-%d',
          }
      },

      series: [{
          name: 'Tweets Per Minute',
          data: data,
          dataGrouping: {
            enabled: false
          }
        }]
    });
  }
}

$(document).ready(function() {
  Chart.init();
})
