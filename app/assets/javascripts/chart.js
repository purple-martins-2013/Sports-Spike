Highcharts.setOptions({
      global: {
        useUTC: false
      }
});

function makeTweetGraph() {
  var myChart = {

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
        myChart.draw(newData);
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

  return myChart
}


function makePulseChart() {
 var pulseChart = {

    pulseTime: 60000,

    init: function() {
      this.render();
      this.poll();
      
    },

    poll: function() {
      setInterval(this.render, this.pulseTime)
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
        pulseChart.draw(newData);
      });
    },

    draw: function(data) {
      new Highcharts.Chart({
        chart: {
            renderTo: 'container',
            type: 'gauge',
            plotBorderWidth: 1,
            plotBackgroundColor: {
                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                stops: [
                    [0, '#FFF4C6'],
                    [0.3, '#FFFFFF'],
                    [1, '#FFF4C6']
                ]
            },
            plotBackgroundImage: null,
            height: 200
        },
    
        title: {
            text: 'Patriot Nation Excitement'
        },
        
        pane: [{
            startAngle: -45,
            endAngle: 45,
            background: null,
            center: ['25%', '145%'],
            size: 300
        }],
        yAxis: [{
            min: -20,
            max: 6,
            minorTickPosition: 'outside',
            tickPosition: 'outside',
            labels: {
                rotation: 'auto',
                distance: 20
            },
            plotBands: [{
                from: 0,
                to: 6,
                color: '#C02316',
                innerRadius: '100%',
                outerRadius: '105%'
            }],
            pane: 0,
            title: {
                text: 'VU<br/><span style="font-size:8px">Get Excited</span>',
                y: -40
            },
        }],
        plotOptions: {
          gauge: {
            dataLabels: {
              enable: false
            },
          },
          dial: {
            radius: '100%'
          }
        },
        series: {
            data: [-20],
            yAxis: 0
        }

      });
    }
  }

  return pulseChart
}
