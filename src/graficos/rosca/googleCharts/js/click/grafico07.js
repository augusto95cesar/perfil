var corGraphicDefalt = "#4F4F4F";
var corGraphicValor = "#00FFFF";
var nameGraphicIndicadorVenda = "graphic-venda";
var indicadorVenda = 1;
var valorVedido = 0;

var optionsIndicadorVendas = {
    backgroundColor: { fill: 'transparent' },
    slices: {
        0: {
            color: corGraphicValor
        },
        1: {
            color: corGraphicDefalt
        },
        2:{
            color: 'transparent'
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
    },
    pieStartAngle: 270
};
 
google.charts.load('current', { 'packages': ['corechart'] });
google.charts.setOnLoadCallback(function () {
    var init = InitGraphicIndicadorVendas();
    init.chart.draw(init.data, optionsIndicadorVendas);
    AnimationGraphicRosca(init.chart, init.data, indicadorVenda, valorVedido);
});

function InitGraphicIndicadorVendas() {
    var chart = new google.visualization.PieChart(document.getElementById(nameGraphicIndicadorVenda));
    data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Vendido', 0],
        ['Meta', 1],
        [null, indicadorVenda + valorVedido]
    ]);
    return {
        chart: chart,
        data: data
    };
}
 
$(".g-text").click(function () {
    html = $.parseHTML(ModalGraphicIndicador());
    $("#g-graphic").prepend(html);
    $("#gindicadordemetasvendas").val(indicadorVenda)
    document.getElementById("gremovermodal").addEventListener('click', function () {
        RemoverModalIndicadorVendas();
    }, false);

    document.getElementById("gsalvarindicadorvendas").addEventListener('click', function () {
        var indicador = IndicadorVendas();
        var valor = ValorVendido();
        AtualizarGraphicIndicadorVendas(indicador, valor)
        RemoverModalIndicadorVendas();
    }, false);
});

function IndicadorVendas() {
    var indicador = $("#gindicadordemetasvendas").val();
    if (isNaN(indicador)) {
        return indicadorVenda;
    }

    if (indicador == "") {
        return indicadorVenda;
    }

    indicadorVenda = indicador;
    return indicadorVenda;
}

function ValorVendido() {
    var valor = $("#valor-text-indicador-vendas").val();
    if (isNaN(valor)) {
        return valorVedido;
    }
    if (valor == "") {
        return valorVedido;
    }
    valorVedido = valor;
    return valorVedido;
}

function AtualizarGraphicIndicadorVendas(indicador, valor) {
    var init = InitGraphicIndicadorVendas();
    init.chart.draw(init.data, optionsIndicadorVendas);
    AnimationGraphicRosca(init.chart, init.data, indicador, valor);
}

function RemoverModalIndicadorVendas() {
    $("#g-indicador-vendas").remove();
}

function ModalGraphicIndicador() {
    var text = '';
    text += '<div id="g-indicador-vendas">';
    text += '<div class="margin-auto">';
    text += '<h4>Indicador Vendas</h6>';
    text += '<input  id="gindicadordemetasvendas" placeholder="R$ 00,00">';
    text += '<button id="gsalvarindicadorvendas">salvar</button>';
    text += '<button id="gremovermodal">Cancelar</button>';
    text += '</div>';
    text += '</div>';
    return text;
}

function AnimationGraphicRosca(chart, data, meta, valor) {

    var percent = 0;
    meta = parseFloat(meta)
    valor = parseFloat(valor)
    //Verificação 
    if (valor > meta) {
        meta = valor;
    }

    var handler = setInterval(function () {
        percent += 20;

        if (percent >= valor) {
            $("#g-text-valor").text(valorVedido);
            data.setValue(0, 1, valor);
            data.setValue(1, 1, meta - valor);
            data.setValue(2, 1, meta);
        } else {
            data.setValue(0, 1, percent);
            data.setValue(1, 1, meta - percent);
            data.setValue(2, 1, meta );
            $("#g-text-valor").text(percent);
        }

        chart.draw(data, optionsIndicadorVendas);

        if (percent > (valor - 1)) {
            clearInterval(handler);
            $("#g-text-valor").text(valorVedido);
        }
    });
}