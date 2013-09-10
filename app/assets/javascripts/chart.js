var Chart = {
  pollTime: 61000,

  init: function() {
    this.render();
    this.poll();
    
  },

  poll: function() {
    setInterval(this.render, this.pollTime)
  },

  render: function() {
    $.get('redis_trips/render_data', Chart.draw);
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
        enabled: true
      },

      scrollBar: {
          enabled: true,
          liveRedraw: false
      },
      xAxis: {
          type: 'datetime',
          tickInterval: 3600 * 1000,
          tickWidth: 0,
          gridLineWidth: 1
      },

      series: [{
          data: data}]
    });
  }
}

$(document).ready(function() {
  Chart.init();
})
