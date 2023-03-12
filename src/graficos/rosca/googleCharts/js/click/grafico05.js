var corGraphicDefalt = "#4F4F4F";
var corGraphicValor = "#00FFFF"; 
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
        width: '90%',
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

var indicadorVenda = 1;
var valorVedido = 0;

google.charts.load('current', { 'packages': ['corechart'] });
google.charts.setOnLoadCallback(function () {
    var chart = new google.visualization.PieChart(document.getElementById('graphic-venda'));
    data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Vendido', valorVedido],
        ['Meta', indicadorVenda]
    ]);
    chart.draw(data, options);
    AnimationGraphicRosca(chart, data, indicadorVenda, valorVedido);
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
    document.getElementById('g-text-valor').innerText = valorVedido;
    data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Vendido', valorVedido],
        ['Meta', indicadorVenda]
    ]);
    chart.draw(data, options);
    AnimationGraphicRosca(chart, data, 1500, 1000);
});


function ModalGraphicIndicador() {
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

function AnimationGraphicRosca(chart, data, meta, valor) {
    var percent = 0;
    
    if(meta< valor)
    {
        meta=valor;
    }

    var handler = setInterval(function () {
        percent += 20;

        if (percent >= valor) {
            $("#g-text-valor").text(valor); 
            data.setValue(0, 1, valor);
            data.setValue(1, 1, meta - valor);
        } else {
            data.setValue(0, 1, percent);
            data.setValue(1, 1, meta - percent);
            $("#g-text-valor").text(percent);
        }

        chart.draw(data, options);

        if (percent > (valor - 1))
            clearInterval(handler);
    });
}