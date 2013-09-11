Highcharts.setOptions({
      global: {
        useUTC: false
      }
});

var MyChart = {

  pollTime: 60000,

  init: function() {
    this.render();
    this.poll();
    
  },

  poll: function() {
    setInterval(this.render, this.pollTime)
  },

  render: function() {
    var pathname = window.location.pathname;
    var id = pathname[pathname.length - 1];
    console.log(id);
    $.get('/search_terms/' + id, function(data) {
      var newData = [];
      var data = $.each(data, function(k, coordinate) {
        newData.push([Date.parse(coordinate[0]), coordinate[1]]);
      });
      MyChart.draw(newData);
    });
  },

  draw: function(data) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'chart'
      },
      title: {
        text: null
      },
      navigator: {
        enabled: true,
        adaptToUpdatedData: false

      },

      rangeSelector: {
        enabled: true,
        inputEnabled: false,
        buttons: [{
            type: 'all',
            text: 'All'
        },{
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
            text: '1 day'
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
          },
          minRange: 180 * 1000
      },

      yAxis: {
        enabled: false
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


