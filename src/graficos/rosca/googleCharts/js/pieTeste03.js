
 
<!--
#donut_single::after{

content: 'Augusto';
font-size: 500%;
display: block;
height: 13px;
position: absolute;

top: 0;
margin:0px auto;
z-index:99;

text-align: center;
float: center;
  
}
--><!-- <div id="pie"></div>
oieeee -->
<!-- <div class="chart-auvo">
<div id="chart"></div>
</div> -->


<!-- <script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {packages: ['corechart']});
google.charts.setOnLoadCallback(drawChart); 

function drawChart(){
// const container = document.querySelector("#chart")

var data = google.visualization.arrayToDataTable([
     ['Element', 'Density', { role: 'style' }, { role: 'annotation' } ],
     ['Copper', 8.94, '#b87333', 'Cu' ],
     ['Silver', 10.49, 'silver', 'Ag' ],
     ['Gold', 19.30, 'gold', 'Au' ],
     ['Platinum', 21.45, 'color: #e5e4e2', 'Pt' ]
  ]);
  const options = {
      title: 'Vai Pra Puta',
      slices: {
            0: {
                color: 'transparent'
            }
       }
  }

  //const chart = new google.visualization.ColumnChart(container)
 // chart.draw(data,options)

  var option = { 
    pieHole: 0.5,  
    height:500,
    widht:200,
      pieSliceText: 'value',
      pieStartAngle: 270,
      slices: {
            2: {
                color: 'transparent'
            }
       },
       legend: 'none'
    };

    var pie = new google.visualization.PieChart(document.getElementById('pie'));
    pie.draw(data, option);
}



</script> -->