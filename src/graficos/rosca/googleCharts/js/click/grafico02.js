var corGraphicDefalt = "#4F4F4F";
var corGraphicValor = "#00FFFF";
var valorIncialVenda = 12000;
var valorIndicadorVendas = 0;
var options = {
    backgroundColor: { fill: 'transparent' },
    slices: {
        0: {
            color: corGraphicValor
        },
        1: {
            color: corGraphicDefalt
        }
    },
    pieHole: 0.7,
    showLables: 'false',
    pieSliceText: 'none',
    pieSliceTextStyle: {
        color: 'white',
        fontSize: 18
    },
    legend: 'none',
    chartArea: {
        width: '100%',
        height: '100%' 
    },
    tooltip: {
        textStyle: { bold: true, color: '#000000', fontSize: 13 },
        showColorCode: true,
        isHtml: true,
        ignoreBounds: false,
        text: 'both',
        trigger: 'selection'
    },
    animation: {
        duration: 5000,
        easing: 'out',
        status: true
    } 
};

google.charts.load('current', { 'packages': ['corechart'] });
google.charts.setOnLoadCallback(function () { 
    var chart = new google.visualization.PieChart(document.getElementById('graphic-venda'));
    
    data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Vendido', valorIncialVenda],
        ['Meta', valorIndicadorVendas]
    ]);
    chart.draw(data, options);
});


$(".g-text").click(function () {
    // html = $.parseHTML(ModalGraphicIndicador());
    // $("#teste").prepend(html);  

//   var btnCancelar =   document.getElementById("g-cancelar-modal-indicador")
//     console.log(btnCancelar)
    
//   btnCancelar .addEventListener('click', function (){
//         $("#g-parent-modal-venda").remove();
//     } , false)

 


    var chart = new google.visualization.PieChart(document.getElementById('graphic-venda'));
    valorIncialVenda = 500,5;
    valorIndicadorVendas=1500;
    document.getElementById('g-text-valor').innerText = valorIncialVenda;
    data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Vendido', valorIncialVenda],
        ['Meta', valorIndicadorVendas]
    ]);
    chart.draw(data, options);
});


function ModalGraphicIndicador(){
    var text = '';
    text += '<div id="g-indicador-vendas">';
    text += '<div class="margin-auto">';
    text += '<h4>Indicador Vendas</h6>';
    text += '<input placeholder="R$ 00,00">';
    text += '<button>salvar</button>';
    text += '<button id="g-cancelar-modal-indicador">Cancelar</button>';
    text += '</div>';
    text += '</div>';
 return text;
}