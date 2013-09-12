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
      $.get('/team_pulse/' + teamOneId + '/' + teamTwoId, function(stats) {
        console.log(stats)
        var teamOne = [];
        $.each(stats.tweets_by_team_one, function(k, coordinate) {
          teamOne.push([Date.parse(coordinate[0]), coordinate[1]]);
        });
        var teamTwo = [];
        $.each(stats.tweets_by_team_two, function(k, coordinate) {
          teamTwo.push([Date.parse(coordinate[0]), coordinate[1]]);
        });
        myChart.draw(teamOne, teamTwo);
      });
    },

    draw: function(data1, data2) {
      new Highcharts.Chart({
        chart: {
          renderTo: 'chart',
          type: 'areaspline',
          defaultSeriesType: 'spline'
        },
        title: {
          text: teamOneName + ' vs ' + teamTwoName
        },
        navigator: {
          enabled: true,
          adaptToUpdatedData: true

        },

        rangeSelector: {
          enabled: true,
          inputEnabled: false,
          buttonSpacing: 1,
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
              text: 'Day'
          }
          ],
          buttonTheme: { // styles for the buttons
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
        
        plotOptions: {
          series: {
            marker: {
              enabled: false,
              states: {
                hover: {
                  enabled: true
                }
              }
            }
          }
        },
        scrollbar: {
          enabled: true,
          liveRedraw: true
        },

        legend: {
          enabled: true,
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
          min: 0,

        },

        series: [{
    
            name: 'Team One',
            data: data1,
            threshold: null,
            dataGrouping: {
              enabled: true
            },
            },{
            name: 'Team Two',
            data: data2,
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

    pulseTime: 60000,

    init: function() {
      this.render();
      this.poll();
      
    },

    poll: function() {
      setInterval(this.render, this.pulseTime)
    },

    render: function() {
      $.get('/team_pulse/' + teamOneId + '/' + teamTwoId, function(stats) {
        var pulseDataTeamOne = stats.fan_pulse_team_one;
        var pulseDataTeamTwo = stats.fan_pulse_team_two;
        pulseChart.draw(pulseDataTeamOne, pulseDataTeamTwo);
      });
    },

    draw: function(data1, data2) {
    //   if (!pulseChart.chart) {
    //     pulseChart.createChart()
    //   }
    //   else 
    //   chart.series[0].data[0].update.(data1);
    //   chart.series[1].data[0].update.(data2);
    //   chart.redraw();
    // },
    // createChart: function(data1, data2) {
    //   this.chart = new Highcharts.Chart({
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
            text: 'Fan Excitement'
        },
        
        pane: [{
            startAngle: -45,
            endAngle: 45,
            background: null,
            center: ['25%', '145%'],
            size: 300
          },{
            startAngle: -45,
            endAngle: 45,
            background: null,
            center: ['75%', '145%'],
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
                text: 'Team One',
                y: -40
            }
        }, {
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
            pane: 1,
            title: {
                text: 'Team Two',
                y: -40
            }
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
            data: data1,
            name: teamOneName,
            yAxis: 0
            }, {
            data: data2,
            name: teamTwoName,
            yAxis: 1
        }]

      });
    }
  }

  return pulseChart
}

