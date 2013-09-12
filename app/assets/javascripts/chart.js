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
      $.get('/search_terms/' + id, function(stats) {
        var newData = [];
        $.each(stats.tweets_by_time, function(k, coordinate) {
          newData.push([Date.parse(coordinate[0]), coordinate[1]]);
        });
        myChart.draw(newData);
      });
    },

    draw: function(data) {
      new Highcharts.Chart({
        chart: {
          renderTo: 'chart',
          type: 'areaspline'
        },
        title: {
          text: null
        },
        navigator: {
          enabled: true,
          adaptToUpdatedData: true

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
          enabled: true,
          min: 0
        },

        series: [{
    
            name: 'Tweets Per Minute',
            data: data,
            threshold: null,
            dataGrouping: {
              enabled: true
            }
          }]
      });
    }
  }
  
  return myChart
}


function makePulseChart() {
 var pulseChart = {

    pulseTime: 6000,

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
      $.get('/search_terms/' + id, function(stats) {
        var pulseData = stats.fan_pulse
        pulseChart.draw(pulseData);
      });
    },

    draw: function(data) {
      console.log(data)
      if (!this.chart) {
        this.createChart()
      }
      this.chart.series[0].points[0].update(data, false)
      this.chart.redraw();
    },
    createChart: function() {
      this.chart = new Highcharts.Chart({
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
            center: ['50%', '140%'],
            size: 300
        }],
        yAxis: [{
            min: 0,
            max: 15,
            minorTickPosition: 'outside',
            tickPosition: 'outside',
            tickInterval: 5,
            labels: {
                rotation: 'auto',
                distance: 20
            },
            plotBands: [{
                from: 12,
                to: 15,
                color: '#C02316',
                innerRadius: '100%',
                outerRadius: '105%'
            }],
            pane: 0,
            title: {
                text: 'Get Excited',
                y: -40
            },
        }],
        plotOptions: {
          gauge: {
            dataLabels: {
              enable: true
            },
          },
          dial: {
            radius: '100%'
          }
        },
        series: [{
            data: [0],
            dataLabels: {
              y: -90
            }
        }]

      });
    }
  }

  return pulseChart
}
