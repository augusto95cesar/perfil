google.charts.load('current', { 'packages': ['corechart'] });

function graficoBltec() {
    var opcao = {
        _indetificador: "grafico",
        _largura: "250",
        _altura: "250",
        _background: "transparent",
        _tipoGrafico: "rosca",
        _magin: "auto",
        _corMeta: "#4F4F4F",
        _corValor: "#00FFFF",
        _idGrafico: "padrao",
        _meta: 0,
        _valorVendido: 0,
        _velocidade: "10",
        _graficoDe:"Vendas"
    }

    this.setNomeGrafico = (nomeGrafico) => { opcao._graficoDe = nomeGrafico; }
    this.setIndetificador = (indetificador) => { opcao._indetificador = indetificador; } 
    this.setLargura = (largura) => { opcao._largura = largura; }
    this.setAltura = (altura) => { opcao._altura = altura; }
    this.setBackground = (background) => { opcao._background = background; }
    this.setTipoGrafico = (tipoGrafico) => { opcao._tipoGrafico = tipoGrafico; }

    this.setCorMeta = (meta) => { opcao._corMeta = meta; }
    this.setCorValor = (valor) => { opcao._corValor = valor; }
    this.setValorVendido = (valor) => { opcao._valorVendido = valor; }
    this.setMeta = (meta) => { opcao._meta = meta; }
    this.setTamanhoGraficoRosca = (tamanho) => { opcao._altura = tamanho; opcao._largura = tamanho; }
    this.setVelocidade = (velocidade) => { opcao._velocidade = velocidade; }

    this.init = () => { CreateGrafico(opcao); }
}

function CreateGrafico(op) {
  document.getElementById(op._indetificador).innerHTML = '';
    if (op._indetificador != "" && op._tipoGrafico == 'rosca') {
        var texto = "";
        texto += "<div id='" + op._indetificador + "bltecroscatexto'>";
        texto += "<span id='" + op._indetificador + "bltecroscamoeda' >R$ </span>";
        texto += "<span id='" + op._indetificador + "bltecroscavalor'>00,00</span></div>";
        texto += "<div id='" + op._indetificador + "bltecroscagrafico'></div>";
        texto += "<div id='" + op._indetificador + "blteDescricao'>" + op._graficoDe + "</div>";
        
        html = $.parseHTML(texto);
        $("#" + op._indetificador).prepend(html);
        CreategraficoGoogleCharts(op);
        CssGraficoRosca(op);
        ClickTextoRosca(op);

    } else {
        console.log("diferente de rosca")
    }
}

function CssGraficoRosca(op) { 
    $("#" + op._indetificador).css("height", op._altura);
    $("#" + op._indetificador).css("width", op._largura);
    $("#" + op._indetificador).css("background", op._background);
    $("#" + op._indetificador).css("position", "relative");
    $("#" + op._indetificador).css("border-radius", "50%");
   // $("#" + op._indetificador).css("margin", "auto");
    //filho
    $("#" + op._indetificador + "bltecroscatexto").css("margin", "0");
    $("#" + op._indetificador + "bltecroscatexto").css("position", "absolute");
    $("#" + op._indetificador + "bltecroscatexto").css("top", "50%");
    $("#" + op._indetificador + "bltecroscatexto").css("left", "50%");
    $("#" + op._indetificador + "bltecroscatexto").css("margin-right", "-50%");
    $("#" + op._indetificador + "bltecroscatexto").css("transform", "translate(-50%, -50%)");
    $("#" + op._indetificador + "bltecroscatexto").css("z-index", "2");
    $("#" + op._indetificador + "bltecroscatexto").css("font-size", op._largura / 10);
    //filho:hover
    $("#" + op._indetificador + "bltecroscatexto").hover(function () {
        $("#" + op._indetificador + "bltecroscatexto").css("cursor", "pointer");
    });
    //blteDescricao
    $("#" + op._indetificador + "blteDescricao").css("text-align", "center");
    $("#" + op._indetificador + "blteDescricao").css("width", "100%");
    $("#" + op._indetificador + "blteDescricao").css("font-size", op._largura / 10);
}

function CreategraficoGoogleCharts(op) {

    var confGrafico = {
        width: op._largura,
        height:op._altura,
        backgroundColor: { fill: 'transparent' },
        slices: {
            0: {
                color: op._corValor
            },
            1: {
                color: op._corMeta
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
            height: '90%'

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


    var chart = new google.visualization.PieChart(document.getElementById(op._indetificador + "bltecroscagrafico"));
    data = google.visualization.arrayToDataTable([
        ['Task', 'Hours per Day'],
        ['Vendido', 0],
        ['Meta', 1]
    ]);


    chart.draw(data, confGrafico);
    // google.charts.setOnLoadCallback(function () {
    // });

    var percent = 0;
    var meta = parseFloat(op._meta);
    var valor = parseFloat(op._valorVendido);
    //Verificação 
    if (valor > meta) {
        meta = valor;
    }

    var velocidade = valor / op._velocidade;


    var handler = setInterval(function () {
        percent += velocidade;

        if (percent >= valor) {
            $("#" + op._indetificador + "bltecroscavalor").text(op._valorVendido);
            data.setValue(0, 1, valor);
            data.setValue(1, 1, meta - valor);
        } else {
            data.setValue(0, 1, percent);
            data.setValue(1, 1, meta - percent);
            $("#" + op._indetificador + "bltecroscavalor").text(percent);
        }

        chart.draw(data, confGrafico);

        if (percent > (valor - 1)) {
            clearInterval(handler);
            $("#" + op._indetificador + "bltecroscavalor").text(op._valorVendido);
        }
    });
 
}

function ClickTextoRosca(op) {
    document.getElementById(op._indetificador + "bltecroscavalor").addEventListener('click', function () {
        // GraficoRoscaFunction(function(){ alert('testando')})
        ModalGraficoRosca(op)
    }, false);
}



function ModalGraficoRosca(op) {

    var text = "<div id='" + op._indetificador + "bltecmodal'>";
    text += "<div id='" + op._indetificador + "bltecmodalindicador'></div>";
    text += "<div id='" + op._indetificador + "bltecmodalinterno'>";
    text += "<label class='control-label'>IndicadordeVendas</label>";
    text += "<input id='" + op._indetificador + "bltecnovoIndicador'  placeholder='Meta' class='form-control' value='" + op._meta + "'>";
    text += "<div id='" + op._indetificador + "bltecmodalbutton' class='row'>";
    text += "<div class='col-sm-6'>";
    text += "<input id='" + op._indetificador + "bltecmodalcancelar'";
    text += "class='btn btn-secondary' type='button' value='Cancelar'";
    text += "style='width:100%;height:40px;'>";
    text += "</div>";
    text += "<div class='col-sm-6'>";
    text += "<input id='" + op._indetificador + "bltecmodalsalvar'";
    text += "class='btn btn-primary' type='button' value='Salvar'";
    text += "style='width:100%; height:40px;'>";
    text += "</div>";
    text += "</div>";
    text += "</div>";

    text += "</div>";
    html = $.parseHTML(text);
    $("body").prepend(html);

    $("#" + op._indetificador + "bltecmodal").css("align-items", "center");
    $("#" + op._indetificador + "bltecmodal").css("justify-content", "center");
    $("#" + op._indetificador + "bltecmodal").css("top", "0");
    $("#" + op._indetificador + "bltecmodal").css("left", "0");
    $("#" + op._indetificador + "bltecmodal").css("height", "50vh");
    $("#" + op._indetificador + "bltecmodal").css("width", "50vw");

    //css
    $("#" + op._indetificador + "bltecmodalindicador").css("position", "absolute");
    $("#" + op._indetificador + "bltecmodalindicador").css("width", "100vw");
    $("#" + op._indetificador + "bltecmodalindicador").css("height", "100vh");
    $("#" + op._indetificador + "bltecmodalindicador").css("background-color", "#222");
    $("#" + op._indetificador + "bltecmodalindicador").css("z-index", "5");

    //css interno
    $("#" + op._indetificador + "bltecmodalinterno").css("background", "white");
    $("#" + op._indetificador + "bltecmodalinterno").css("height", "50vh");
    $("#" + op._indetificador + "bltecmodalinterno").css("width", "50vw");
    $("#" + op._indetificador + "bltecmodalinterno").css("padding", "30px");
    $("#" + op._indetificador + "bltecmodalinterno").css("border-radius", "25px");
    $("#" + op._indetificador + "bltecmodalinterno").css("position", "relative");
    $("#" + op._indetificador + "bltecmodalinterno").css("z-index", "10");
    $("#" + op._indetificador + "bltecmodalinterno").css("top", "50%");
    $("#" + op._indetificador + "bltecmodalinterno").css("left", "50%");

    //css position butto
    $("#" + op._indetificador + "bltecmodalbutton").css("position", "absolute");
    $("#" + op._indetificador + "bltecmodalbutton").css("bottom", "30px");
    $("#" + op._indetificador + "bltecmodalbutton").css("width", "95%");

    //remover modal
    document.getElementById(op._indetificador + "bltecmodalindicador").addEventListener('click', function () {
        $("#" + op._indetificador + "bltecmodal").remove();
    }, false);

    document.getElementById(op._indetificador + "bltecmodalcancelar").addEventListener('click', function () {
        $("#" + op._indetificador + "bltecmodal").remove();
    }, false);

    document.getElementById(op._indetificador + "bltecmodalsalvar").addEventListener('click', function () {
        op._meta = $("#" + op._indetificador + "bltecnovoIndicador").val();  
        AtualizarGraficoRosca(op); 
    }, false);
}

function AtualizarGraficoRosca(opcao) {
    if (AjaxIndicadorVendas(opcao)) {
        $("#" + opcao._indetificador + "bltecmodal").remove();
        novo = new graficoBltec()
        novo.setIndetificador(opcao._indetificador)
        novo.setTamanhoGraficoRosca(opcao._largura)
        novo.setMeta(opcao._meta)
        novo.setValorVendido(opcao._valorVendido)
        novo.init()
    }else{
        console.log("throw Implemantar a function bool AjaxIndicadorVendas(opcao)!");
        alert("throw Implemantar a function bool AjaxIndicadorVendas(opcao)!");
    }
}

// function de implemantation de serviço
function AjaxIndicadorVendas(opcao) { }

function gRoscaBltec(id, meta, valor, tamanhoGrafico ,nomeGrafico) {
    novo = new graficoBltec();
    novo.setIndetificador(id);
    novo.setTamanhoGraficoRosca(tamanhoGrafico);
    novo.setMeta(meta);
    novo.setNomeGrafico(nomeGrafico);
    novo.setValorVendido(valor);
    novo.init(); 
}