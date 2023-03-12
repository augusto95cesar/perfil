google.charts.load('current', {'packages':['corechart']});  
google.charts.setOnLoadCallback(drawChart);
google.charts.setOnLoadCallback(drawChartTextCenter);

function drawChart() {

  var data = google.visualization.arrayToDataTable([
    ['Effort', 'Amount given'],
    ['My all',     100],
    ['My all z',     97],
  ]);

  var options = {
    pieHole: 0.8, 
    chartArea: {'width': '100%', 'height': '100%'},    
    pieSliceTextStyle: {
      color: 'black' 
    },
    legend: 'none',
    pieSliceText: 'none', 
    backgroundColor: { fill:'transparent' },
    tooltip: {
        trigger:'none'
    },
    slices: {
        0: {
            color: 'black'
        },
        1:{
            color: 'blue'
        }
   }
  };

  var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
  chart.draw(data, options);
}
 
function drawChartTextCenter() {
    var data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Work',     85],
        ['Eat',      15] 
    ]);

    var options = {  
        chartArea: {'width': '100%', 'height': '100%'},   
        backgroundColor: { fill:'transparent' },
        pieHole: 0.8,
        showLables: 'true',
        pieSliceText: 'none',
        pieSliceTextStyle: {
            color: 'white',
            fontSize:18
        },
        legend: 'none',
        chartArea: { 
            left: 0, 
            top: 0, 
            width: '100%', 
            height: '100%'
        },
        tooltip: {
            trigger:'none'
        }
    };

   var chart = new google.visualization.PieChart(document.getElementById('chart_div')); 
    chart.draw(data, options);
}