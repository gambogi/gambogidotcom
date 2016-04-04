var data = [];

var last = 14;

var days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

for (var i=0; i<7; i += 1) {
    var d = Math.floor(last + 2 * Math.random() * Math.pow(-1, Math.floor(Math.random()*2)));
    var y = 2006 + i;
    data.push({day:days[i], dist: d});
}

var parsedData = d4.parsers.nestedGroup()
    .x(function(){return 'day';})
    //.nestKey(function(){return 'runner';})
    .y(function(){return 'dist';})
    .value(function(){return 'dist'})
    (data);

var columnChart = d4.charts.column()
    .x(function(x){x.key('day');})
    .y(function(y){y.key('dist');});


d3.select('#chart1')
  .datum(parsedData.data)
  .call(columnChart);


