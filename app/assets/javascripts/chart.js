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

      rangeSelector: {
        enabled: true,
        inputEnabled: false,
        buttons: [{
            type: 'hour',
            count: 1,
            text: '1hr'
        },{
            type: 'hour',
            count: 4,
            text: '4hr'
        },{
            type: 'day',
            count: 1,
            text: 'day'
        }
        ],
        buttonTheme: { // styles for the buttons
          fill: 'none',
          stroke: 'none',
          'stroke-width': 0,
          r: 8,
          style: {
            color: '#039',
            fontWeight: 'bold'
          },
          states: {
            hover: {
            },
            select: {
              fill: '#039',
              style: {
                color: 'white'
              }
            }
          }
        },
        inputStyle: {
          color: '#039',
          fontWeight: 'bold'
        },
        labelStyle: {
          color: 'silver',
          fontWeight: 'bold'
        },

      },
      

      scrollbar: {
        enabled: true,
        liveRedraw: true
      },

      legend: {
        enabled: false
      },
      plotOptions: {
        cropThreshold:10000
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
          turboThreshold: 10000,
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
