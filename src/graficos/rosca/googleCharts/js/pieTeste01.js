google.charts.load('current', {'packages':['corechart']});  
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

  var data = google.visualization.arrayToDataTable([
    ['Effort', 'Amount given'],
    ['My all',     100],
  ]);

  var options = {
    pieHole: 0.5, 
    chartArea: {'width': '100%', 'height': '100%'},
    pieSliceTextStyle: {
      color: 'black' 
    },
    legend: 'none',
    pieSliceText: 'none',
    
    backgroundColor: { fill:'transparent' }
  };

  var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
  chart.draw(data, options);
}