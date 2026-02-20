<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>db flow · modal corrigido</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Roboto, sans-serif;
            background: #1e1e2f;
            height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            color: #eee;
        }
        .toolbar {
            background: #2a2a3a;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 20px;
            border-bottom: 1px solid #3d3d5a;
            flex-wrap: wrap;
        }
        .toolbar-group {
            display: flex;
            gap: 8px;
            background: #1f1f2b;
            padding: 5px 10px;
            border-radius: 30px;
            border: 1px solid #3a3a50;
        }
        .tool-btn {
            background: transparent;
            border: none;
            color: #ccc;
            font-size: 1.2rem;
            padding: 6px 10px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.15s;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .tool-btn i { font-size: 1.1rem; }
        .tool-btn:hover { background: #3a3a55; color: white; }
        .tool-btn.active { background: #5a5a8a; color: white; }
        .tool-btn.danger:hover { background: #aa4466; }
        .separator { width: 1px; height: 28px; background: #44445a; margin: 0 5px; }
        .canvas-title {
            font-weight: 600;
            color: #b0b0d0;
            margin-left: auto;
            background: #232334;
            padding: 6px 16px;
            border-radius: 40px;
            border: 1px solid #43435a;
        }
        .main-area { display: flex; flex: 1; overflow: hidden; }
        .shapes-panel {
            width: 260px;
            background: #252536;
            border-right: 1px solid #3d3d5a;
            display: flex;
            flex-direction: column;
            padding: 20px 12px;
            gap: 20px;
            overflow-y: auto;
        }
        .panel-section h4 {
            font-size: 0.8rem;
            text-transform: uppercase;
            color: #9a9ac0;
            margin-bottom: 12px;
            border-bottom: 1px dashed #4d4d6a;
            padding-bottom: 5px;
        }
        .shape-item {
            background: #2f2f44;
            border: 1px solid #4c4c70;
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: grab;
            transition: 0.1s;
            color: #ddd;
        }
        .shape-item i { font-size: 1.2rem; color: #aac3ff; width: 24px; }
        .shape-item:hover { background: #3d3d60; border-color: #8a8ac0; transform: translateY(-1px); }
        .shape-item:active { cursor: grabbing; }
        .canvas-container {
            flex: 1;
            background: #1a1a28;
            position: relative;
            overflow: auto;
            background-image: linear-gradient(#2c2c40 1px, transparent 1px), linear-gradient(90deg, #2c2c40 1px, transparent 1px);
            background-size: 30px 30px;
        }
        #drawCanvas { 
            display: block; 
            width: 100%; 
            height: 100%; 
            min-width: 1500px; 
            min-height: 1000px;
            cursor: default;
        }
        .status-bar {
            background: #21212e;
            border-top: 1px solid #38384a;
            padding: 4px 20px;
            font-size: 0.8rem;
            color: #9f9fc5;
            display: flex;
            gap: 30px;
            align-items: center;
        }
        .selected-info {
            background: #3a3a5a;
            padding: 2px 12px;
            border-radius: 20px;
            color: #ffd966;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.8);
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }
        .modal-content {
            background: #2a2a3c;
            border-radius: 20px;
            width: 550px;
            max-width: 90vw;
            padding: 25px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.8);
            border: 1px solid #6a6a9a;
            max-height: 85vh;
            overflow-y: auto;
        }
        .modal-content h3 { margin-bottom: 20px; color: #d0d0ff; }
        .modal-field { margin-bottom: 18px; }
        .modal-field label { 
            display: block; 
            font-size: 0.85rem; 
            color: #b1b1dd; 
            margin-bottom: 5px;
            font-weight: 600;
        }
        .modal-field input, .modal-field textarea, .modal-field select {
            width: 100%; 
            background: #1d1d2b; 
            border: 1px solid #54547a; 
            color: white; 
            padding: 10px 12px; 
            border-radius: 12px;
            font-family: inherit;
        }
        .modal-field textarea { height: 100px; resize: vertical; }
        
        .relation-item {
            background: #1f1f30;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 12px;
            border-left: 4px solid #6d6dff;
        }
        .relation-row {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
            align-items: center;
        }
        .relation-row select {
            flex: 1;
            background: #2a2a40;
        }
        .relation-row input {
            flex: 1;
        }
        .btn-remove-relation {
            background: #aa4466;
            border: none;
            color: white;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn-remove-relation:hover {
            background: #cc5588;
        }
        .btn-add-relation {
            background: #4a4a7a;
            border: none;
            color: white;
            padding: 10px 16px;
            border-radius: 30px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-add-relation:hover {
            background: #5a5a9a;
        }
        .relation-type {
            display: flex;
            gap: 15px;
            margin: 10px 0;
            flex-wrap: wrap;
        }
        .relation-type label {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #b0b0dd;
            cursor: pointer;
        }
        .relation-type input[type="radio"] {
            width: auto;
            margin-right: 3px;
            cursor: pointer;
        }
        .modal-actions { 
            display: flex; 
            justify-content: flex-end; 
            gap: 12px; 
            margin-top: 25px;
            border-top: 1px solid #44446a;
            padding-top: 20px;
        }
        .modal-btn { 
            padding: 10px 24px; 
            border-radius: 30px; 
            border: none; 
            font-weight: 600; 
            cursor: pointer; 
            font-size: 14px;
        }
        .modal-btn.primary { 
            background: #6d6dff; 
            color: white; 
        }
        .modal-btn.primary:hover {
            background: #7d7dff;
        }
        .modal-btn.secondary { 
            background: #3a3a55; 
            color: #ccc; 
        }
        .modal-btn.secondary:hover {
            background: #4a4a6a;
        }
        .file-input {
            display: none;
        }
    </style>
</head>
<body>
    <div class="toolbar">
        <div class="toolbar-group">
            <button class="tool-btn active" id="btn-select" title="Selecionar/mover"><i class="fas fa-mouse-pointer"></i> Mover</button>
            <button class="tool-btn" id="btn-table" title="Inserir tabela"><i class="fas fa-table"></i> Tabela</button>
            <span class="separator"></span>
            <button class="tool-btn danger" id="btn-delete" title="Deletar tabela selecionada"><i class="fas fa-trash-alt"></i> Excluir</button>
        </div>
        <div class="toolbar-group">
            <button class="tool-btn" id="btn-save"><i class="fas fa-save"></i> Salvar</button>
			<button class="tool-btn" id="btn-load"><i class="fas fa-spinner"></i> Carragar</button>
            <button class="tool-btn" id="btn-download"><i class="fas fa-download"></i> Exportar JSON</button>
            <button class="tool-btn" id="btn-upload"><i class="fas fa-upload"></i> Importar JSON</button>
            <button class="tool-btn" id="btn-clear"><i class="fas fa-eraser"></i> Limpar</button>
        </div>
        <div class="canvas-title">
			<div class="shape-item" draggable="true" id="drag-custom">
				<i class="fas fa-pen"></i><span>Tabela personalizada</span>
			</div>
        </div>
    </div>
<!--
    <div class="main-area">
        <div class="shapes-panel">
            <div class="panel-section">
                <h4><i class="fas fa-cube"></i> TABELAS PRONTAS</h4>
                <div class="shape-item" draggable="true" id="drag-table-simple">
                    <i class="fas fa-table"></i><span>Cliente (id, nome)</span>
                </div>
                <div class="shape-item" draggable="true" id="drag-table-product">
                    <i class="fas fa-box"></i><span>Produto (id, preço)</span>
                </div>
                <div class="shape-item" draggable="true" id="drag-table-order">
                    <i class="fas fa-shopping-cart"></i><span>Pedido (id, data)</span>
                </div>
                <div class="shape-item" draggable="true" id="drag-custom">
                    <i class="fas fa-pen"></i><span>Tabela personalizada</span>
                </div>
            </div>
            <div style="color:#8a8ab0; font-size:0.75rem; margin-top:20px; padding:8px; border-top:1px solid #3d3d60;">
                <i class="fas fa-info-circle"></i> Duplo clique na tabela para editar<br>
                <i class="fas fa-trash"></i> Delete ou botão excluir para remover<br>
                <i class="fas fa-download"></i> Exporte e importe diagramas
            </div>
        </div>
-->
        <div class="canvas-container" id="canvas-container">
            <canvas id="drawCanvas" width="1500" height="1000"></canvas>
        </div>
    </div>

    <div class="status-bar">
        <span><i class="far fa-circle"></i> Modo: <span id="mode-indicator">selecionar/mover</span></span>
        <span id="selection-status" class="selected-info"><i class="fas fa-check-circle"></i> Nenhuma tabela selecionada</span>
        <span id="coord-status">X: 0, Y: 0</span>
    </div>

    <!-- Modal de edição -->
    <div class="modal" id="tableModal">
        <div class="modal-content">
            <h3><i class="fas fa-edit"></i> Editar tabela e relacionamentos</h3>
            
            <div class="modal-field">
                <label>Nome da tabela</label>
                <input type="text" id="modal-table-name" placeholder="ex: usuarios">
            </div>
            
            <div class="modal-field">
                <label>Colunas (uma por linha)</label>
                <textarea id="modal-table-columns" placeholder="id INT PK&#10;nome VARCHAR(100)&#10;email UNIQUE"></textarea>
            </div>

            <div class="modal-field">
                <label><i class="fas fa-link"></i> Relacionamentos com outras tabelas</label>
                <div id="relations-container"></div>
                <button class="btn-add-relation" id="add-relation-btn">
                    <i class="fas fa-plus-circle"></i> Adicionar relacionamento
                </button>
            </div>

            <div class="modal-actions">
                <button class="modal-btn secondary" id="modal-cancel">Cancelar</button>
                <button class="modal-btn primary" id="modal-save">Salvar alterações</button>
            </div>
        </div>
    </div>

    <!-- Input file oculto para upload -->
    <input type="file" id="file-input" class="file-input" accept=".json,application/json">

    <script>
        (function() {
            const canvas = document.getElementById('drawCanvas');
            const ctx = canvas.getContext('2d');
            const container = document.getElementById('canvas-container');

            // Estrutura de dados
            let tables = [];
            let nextId = 1;
            let currentTool = 'select';
            
            // Variáveis para seleção e drag
            let selectedTableId = null;
            let isDraggingTable = false;
            let draggedTableId = null;
            let dragOffsetX = 0, dragOffsetY = 0;

            // Modal
            const modal = document.getElementById('tableModal');
            const modalName = document.getElementById('modal-table-name');
            const modalColumns = document.getElementById('modal-table-columns');
            const relationsContainer = document.getElementById('relations-container');
            let editingTableId = null;

            // Elementos de status
            const selectionStatus = document.getElementById('selection-status');
            const modeIndicator = document.getElementById('mode-indicator');

            // Atualiza cursor do canvas baseado no que está abaixo do mouse
            function updateCursor(mouseX, mouseY) {
                const tableUnderMouse = getTableAt(mouseX, mouseY);
                if (tableUnderMouse && currentTool === 'select') {
                    canvas.style.cursor = 'grab';
                } else if (isDraggingTable) {
                    canvas.style.cursor = 'grabbing';
                } else {
                    canvas.style.cursor = 'default';
                }
            }

            // Atualiza texto da seleção
            function updateSelectionStatus() {
                if (selectedTableId) {
                    const table = tables.find(t => t.id === selectedTableId);
                    if (table) {
                        selectionStatus.innerHTML = `<i class="fas fa-check-circle"></i> Selecionado: ${table.name}`;
                    } else {
                        selectedTableId = null;
                        selectionStatus.innerHTML = '<i class="fas fa-check-circle"></i> Nenhuma tabela selecionada';
                    }
                } else {
                    selectionStatus.innerHTML = '<i class="fas fa-check-circle"></i> Nenhuma tabela selecionada';
                }
            }

            // ---- Função para encontrar o melhor ponto de conexão ----
            function findBestConnectionPoints(tableA, tableB) {
                const wA = tableA.width || 180;
                const hA = tableA.height || 120;
                const wB = tableB.width || 180;
                const hB = tableB.height || 120;

                const centerAX = tableA.x + wA/2;
                const centerAY = tableA.y + hA/2;
                const centerBX = tableB.x + wB/2;
                const centerBY = tableB.y + hB/2;

                const angle = Math.atan2(centerBY - centerAY, centerBX - centerAX);
                
                let pointAX, pointAY;
                
                if (Math.abs(angle) < Math.PI/4) {
                    pointAX = tableA.x + wA;
                    pointAY = centerAY;
                } else if (angle >= Math.PI/4 && angle < 3*Math.PI/4) {
                    pointAX = centerAX;
                    pointAY = tableA.y + hA;
                } else if (angle <= -Math.PI/4 && angle > -3*Math.PI/4) {
                    pointAX = centerAX;
                    pointAY = tableA.y;
                } else {
                    pointAX = tableA.x;
                    pointAY = centerAY;
                }

                const entryAngle = angle + Math.PI;
                let pointBX, pointBY;
                
                if (Math.abs(entryAngle) < Math.PI/4) {
                    pointBX = tableB.x + wB;
                    pointBY = centerBY;
                } else if (entryAngle >= Math.PI/4 && entryAngle < 3*Math.PI/4) {
                    pointBX = centerBX;
                    pointBY = tableB.y + hB;
                } else if (entryAngle <= -Math.PI/4 && entryAngle > -3*Math.PI/4) {
                    pointBX = centerBX;
                    pointBY = tableB.y;
                } else {
                    pointBX = tableB.x;
                    pointBY = centerBY;
                }

                return {
                    start: { x: pointAX, y: pointAY },
                    end: { x: pointBX, y: pointBY }
                };
            }

            // ---- funções de desenho ----
            function drawBackground() {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.strokeStyle = '#2c2c44';
                ctx.lineWidth = 0.5;
                for (let i = 0; i <= canvas.width; i += 30) {
                    ctx.beginPath();
                    ctx.moveTo(i, 0);
                    ctx.lineTo(i, canvas.height);
                    ctx.stroke();
                }
                for (let i = 0; i <= canvas.height; i += 30) {
                    ctx.beginPath();
                    ctx.moveTo(0, i);
                    ctx.lineTo(canvas.width, i);
                    ctx.stroke();
                }
            }

            function drawRelationships() {
                tables.forEach(table => {
                    if (table.relations && Array.isArray(table.relations)) {
                        table.relations.forEach(rel => {
                            const targetTable = tables.find(t => t.id === rel.targetTableId);
                            if (!targetTable) return;

                            const points = findBestConnectionPoints(table, targetTable);
                            
                            const colors = {
                                '1:1': '#ffaa66',
                                '1:N': '#66ffaa',
                                'N:N': '#aa66ff'
                            };
                            ctx.strokeStyle = colors[rel.type] || '#aa66ff';
                            ctx.lineWidth = 2.5;
                            
                            if (rel.type === 'N:N') {
                                ctx.setLineDash([8, 4]);
                            } else {
                                ctx.setLineDash([]);
                            }
                            
                            ctx.beginPath();
                            ctx.moveTo(points.start.x, points.start.y);
                            
                            const midX = (points.start.x + points.end.x) / 2;
                            const midY = (points.start.y + points.end.y) / 2;
                            const offsetX = (points.end.y - points.start.y) * 0.2;
                            const offsetY = (points.start.x - points.end.x) * 0.2;
                            
                            ctx.quadraticCurveTo(
                                midX + offsetX, 
                                midY + offsetY,
                                points.end.x, 
                                points.end.y
                            );
                            ctx.stroke();
                            
                            ctx.setLineDash([]);
                            
                            const angle = Math.atan2(points.end.y - points.start.y, points.end.x - points.start.x);
                            const arrowSize = 10;
                            
                            ctx.fillStyle = ctx.strokeStyle;
                            ctx.beginPath();
                            ctx.moveTo(points.end.x, points.end.y);
                            ctx.lineTo(
                                points.end.x - arrowSize * Math.cos(angle - 0.3),
                                points.end.y - arrowSize * Math.sin(angle - 0.3)
                            );
                            ctx.lineTo(
                                points.end.x - arrowSize * Math.cos(angle + 0.3),
                                points.end.y - arrowSize * Math.sin(angle + 0.3)
                            );
                            ctx.closePath();
                            ctx.fill();
                            
                            ctx.fillStyle = '#fff';
                            ctx.font = 'bold 10px monospace';
                            ctx.shadowColor = '#000';
                            ctx.shadowBlur = 4;
                            ctx.fillText(
                                rel.type, 
                                (points.start.x + points.end.x) / 2 - 15,
                                (points.start.y + points.end.y) / 2 - 10
                            );
                            ctx.shadowBlur = 0;
                        });
                    }
                });
            }

            function drawTables() {
                tables.forEach(t => {
                    const w = t.width || 180;
                    const h = t.height || 120;
                    
                    ctx.shadowColor = '#00000080';
                    ctx.shadowBlur = 10;
                    ctx.shadowOffsetY = 3;
                    
                    // Destaque se estiver selecionada
                    if (t.id === selectedTableId) {
                        ctx.fillStyle = '#3d3d6d';
                        ctx.shadowColor = '#aaccff';
                        ctx.shadowBlur = 15;
                    } else {
                        ctx.fillStyle = '#2f2f47';
                    }
                    
                    ctx.beginPath();
                    ctx.roundRect(t.x, t.y, w, h, 12);
                    ctx.fill();
                    
                    ctx.shadowBlur = 0;
                    ctx.strokeStyle = t.id === selectedTableId ? '#ffd966' : (draggedTableId === t.id ? '#ffd966' : '#9f9fff');
                    ctx.lineWidth = (t.id === selectedTableId || draggedTableId === t.id) ? 4 : 2;
                    ctx.stroke();
                    
                    // Título
                    ctx.fillStyle = '#ffffff';
                    ctx.font = 'bold 14px "Segoe UI", monospace';
                    ctx.fillText(t.name || 'tabela', t.x + 15, t.y + 28);
                    
                    ctx.beginPath();
                    ctx.strokeStyle = '#6a6a9a';
                    ctx.lineWidth = 1;
                    ctx.moveTo(t.x + 10, t.y + 40);
                    ctx.lineTo(t.x + w - 10, t.y + 40);
                    ctx.stroke();
                    
                    ctx.fillStyle = '#cfcfff';
                    ctx.font = '11px "Segoe UI", monospace';
                    const lines = (t.columns || 'id\nnome').split('\n').slice(0, 3);
                    lines.forEach((line, idx) => {
                        ctx.fillText(line.length > 22 ? line.substr(0,20)+'…' : line, t.x + 15, t.y + 60 + idx*18);
                    });
                    
                    if (t.relations && t.relations.length > 0) {
                        ctx.fillStyle = '#aaddff';
                        ctx.font = 'bold 9px monospace';
                        ctx.fillText(`${t.relations.length} rel.`, t.x + w - 60, t.y + h - 10);
                    }
                });
            }

            CanvasRenderingContext2D.prototype.roundRect = function (x, y, w, h, r) {
                if (w < 2 * r) r = w / 2;
                if (h < 2 * r) r = h / 2;
                this.moveTo(x + r, y);
                this.lineTo(x + w - r, y);
                this.quadraticCurveTo(x + w, y, x + w, y + r);
                this.lineTo(x + w, y + h - r);
                this.quadraticCurveTo(x + w, y + h, x + w - r, y + h);
                this.lineTo(x + r, y + h);
                this.quadraticCurveTo(x, y + h, x, y + h - r);
                this.lineTo(x, y + r);
                this.quadraticCurveTo(x, y, x + r, y);
                return this;
            };

            function redraw() {
                drawBackground();
                drawRelationships();
                drawTables();
                updateSelectionStatus();
            }

            // ---- localizar tabela sob o mouse ----
            function getTableAt(mouseX, mouseY) {
                for (let i = tables.length - 1; i >= 0; i--) {
                    const t = tables[i];
                    const w = t.width || 180;
                    const h = t.height || 120;
                    if (mouseX >= t.x && mouseX <= t.x + w && mouseY >= t.y && mouseY <= t.y + h) {
                        return t;
                    }
                }
                return null;
            }

            // ---- Deletar tabela selecionada ----
            function deleteSelectedTable() {
                if (selectedTableId) {
                    const removedId = selectedTableId;
                    
                    // Remove a tabela
                    tables = tables.filter(t => t.id !== removedId);
                    
                    // Remove referências nos relacionamentos
                    tables.forEach(t => {
                        if (t.relations) {
                            t.relations = t.relations.filter(r => r.targetTableId !== removedId);
                        }
                    });
                    
                    selectedTableId = null;
                    redraw();
                } else {
                    //alert('Clique em uma tabela para selecioná-la antes de excluir');
                }
            }

            // ---- criar tabela a partir do drop ----
            function createTableFromDrop(type, x, y) {
                let name = 'Nova';
                let columns = 'id INT\nnome VARCHAR';
                if (type === 'simple') { name = 'Cliente'; columns = 'id INT PK\nnome VARCHAR(100)\nemail VARCHAR'; }
                else if (type === 'product') { name = 'Produto'; columns = 'id INT PK\npreco DECIMAL\nestoque INT'; }
                else if (type === 'order') { name = 'Pedido'; columns = 'id INT PK\ndata DATE\ncliente_id INT'; }
                else if (type === 'custom') { name = 'Custom'; columns = 'id INT\ncampo1\ncampo2'; }

                const table = {
                    id: nextId++,
                    x: Math.max(30, x - 90),
                    y: Math.max(30, y - 60),
                    name: name,
                    columns: columns,
                    width: 180,
                    height: 120,
                    relations: []
                };
                tables.push(table);
                redraw();
                return table;
            }

            // ---- Renderizar relacionamentos no modal ----
            function renderRelationsModal(currentTableId) {
                const currentTable = tables.find(t => t.id === currentTableId);
                if (!currentTable) return;

                const otherTables = tables.filter(t => t.id !== currentTableId);
                
                let html = '';
                if (currentTable.relations && currentTable.relations.length > 0) {
                    currentTable.relations.forEach((rel, index) => {
                        html += `
                            <div class="relation-item" data-rel-index="${index}">
                                <div class="relation-row">
                                    <select class="relation-target" data-index="${index}">
                                        <option value="">Selecione a tabela...</option>
                                        ${otherTables.map(t => `<option value="${t.id}" ${t.id === rel.targetTableId ? 'selected' : ''}>${t.name}</option>`).join('')}
                                    </select>
                                    <button class="btn-remove-relation" onclick="window.removeRelation(${index})">×</button>
                                </div>
                                <div class="relation-type">
                                    <label>
                                        <input type="radio" name="rel-type-${index}" value="1:1" ${rel.type === '1:1' ? 'checked' : ''}> 1:1
                                    </label>
                                    <label>
                                        <input type="radio" name="rel-type-${index}" value="1:N" ${rel.type === '1:N' ? 'checked' : ''}> 1:N
                                    </label>
                                    <label>
                                        <input type="radio" name="rel-type-${index}" value="N:N" ${rel.type === 'N:N' ? 'checked' : ''}> N:N
                                    </label>
                                </div>
                                <div class="relation-row">
                                    <input type="text" class="relation-field" placeholder="campo de ligação (ex: cliente_id)" value="${rel.field || ''}" data-index="${index}">
                                </div>
                            </div>
                        `;
                    });
                }
                relationsContainer.innerHTML = html || '<p style="color:#8888aa; text-align:center; padding:20px;">Nenhum relacionamento definido</p>';
            }

            // Função global para remover relacionamento
            window.removeRelation = function(index) {
                console.log('Removendo relação', index, 'da tabela', editingTableId);
                if (editingTableId) {
                    const table = tables.find(t => t.id === editingTableId);
                    if (table && table.relations) {
                        table.relations.splice(index, 1);
                        renderRelationsModal(editingTableId);
                    }
                }
            };

            // Adicionar novo relacionamento
            document.getElementById('add-relation-btn').addEventListener('click', () => {
                console.log('Adicionar relação para tabela', editingTableId);
                if (!editingTableId) return;
                
                const table = tables.find(t => t.id === editingTableId);
                if (table) {
                    if (!table.relations) table.relations = [];
                    
                    const otherTable = tables.find(t => t.id !== editingTableId);
                    
                    table.relations.push({
                        targetTableId: otherTable ? otherTable.id : '',
                        type: '1:N',
                        field: 'id_relacionado'
                    });
                    
                    renderRelationsModal(editingTableId);
                }
            });

            // ---- EVENTOS DE DRAG DO PAINEL ----
            const draggables = document.querySelectorAll('.shape-item[draggable="true"]');
            draggables.forEach(el => {
                el.addEventListener('dragstart', (e) => {
                    let type = 'custom';
                    if (el.id.includes('simple')) type = 'simple';
                    else if (el.id.includes('product')) type = 'product';
                    else if (el.id.includes('order')) type = 'order';
                    e.dataTransfer.setData('text/plain', type);
                });
            });

            container.addEventListener('dragover', (e) => e.preventDefault());
            container.addEventListener('drop', (e) => {
                e.preventDefault();
                const rect = canvas.getBoundingClientRect();
                const scrollLeft = container.scrollLeft;
                const scrollTop = container.scrollTop;
                const mouseX = e.clientX - rect.left + scrollLeft;
                const mouseY = e.clientY - rect.top + scrollTop;

                const type = e.dataTransfer.getData('text/plain');
                createTableFromDrop(type, mouseX, mouseY);
            });

            // ---- EVENTOS DE MOUSE ----
            canvas.addEventListener('mousemove', (e) => {
                const rect = canvas.getBoundingClientRect();
                const mouseX = e.clientX - rect.left + container.scrollLeft;
                const mouseY = e.clientY - rect.top + container.scrollTop;

                document.getElementById('coord-status').innerHTML = `X: ${Math.round(mouseX)}, Y: ${Math.round(mouseY)}`;
                
                updateCursor(mouseX, mouseY);

                if (isDraggingTable && draggedTableId !== null) {
                    const table = tables.find(t => t.id === draggedTableId);
                    if (table) {
                        table.x = mouseX - dragOffsetX;
                        table.y = mouseY - dragOffsetY;
                        redraw();
                    }
                }
            });

            canvas.addEventListener('mousedown', (e) => {
                if (currentTool !== 'select') return;

                const rect = canvas.getBoundingClientRect();
                const mouseX = e.clientX - rect.left + container.scrollLeft;
                const mouseY = e.clientY - rect.top + container.scrollTop;

                const table = getTableAt(mouseX, mouseY);
                if (table) {
                    e.preventDefault();
                    
                    selectedTableId = table.id;
                    
                    isDraggingTable = true;
                    draggedTableId = table.id;
                    dragOffsetX = mouseX - table.x;
                    dragOffsetY = mouseY - table.y;
                    
                    canvas.style.cursor = 'grabbing';
                    redraw();
                } else {
                    selectedTableId = null;
                    redraw();
                }
            });

            window.addEventListener('mouseup', () => {
                if (isDraggingTable) {
                    isDraggingTable = false;
                    draggedTableId = null;
                    redraw();
                }
            });

            canvas.addEventListener('mouseleave', () => {
                if (isDraggingTable) {
                    isDraggingTable = false;
                    draggedTableId = null;
                    redraw();
                }
            });

            // ---- Duplo clique para editar ----
            canvas.addEventListener('dblclick', (e) => {
                const rect = canvas.getBoundingClientRect();
                const mouseX = e.clientX - rect.left + container.scrollLeft;
                const mouseY = e.clientY - rect.top + container.scrollTop;

                const table = getTableAt(mouseX, mouseY);
                if (table) {
                    editingTableId = table.id;
                    modalName.value = table.name || '';
                    modalColumns.value = table.columns || '';
                    
                    if (!table.relations) table.relations = [];
                    
                    renderRelationsModal(editingTableId);
                    modal.style.display = 'flex';
                    console.log('Modal aberto para tabela', table.id);
                } else if (currentTool === 'table') {
                    createTableFromDrop('custom', mouseX, mouseY);
                }
            });

            // ---- Botões da toolbar ----
            document.getElementById('btn-select').addEventListener('click', () => {
                currentTool = 'select';
                document.querySelectorAll('.tool-btn').forEach(b => b.classList.remove('active'));
                document.getElementById('btn-select').classList.add('active');
                modeIndicator.innerText = 'selecionar/mover';
            });
            
            document.getElementById('btn-table').addEventListener('click', () => {
                currentTool = 'table';
                document.querySelectorAll('.tool-btn').forEach(b => b.classList.remove('active'));
                document.getElementById('btn-table').classList.add('active');
                modeIndicator.innerText = 'inserir tabela';
            });

            document.getElementById('btn-delete').addEventListener('click', deleteSelectedTable);

            // Tecla Delete
            window.addEventListener('keydown', (e) => {
                if (e.key === 'Delete' || e.key === 'Del') {
                    deleteSelectedTable();
                }
            });

            document.getElementById('btn-clear').addEventListener('click', () => {
                //if (confirm('Limpar todas as tabelas?')) {
                    tables = [];
                    nextId = 1;
                    selectedTableId = null;
                    redraw();
                //}
            });

            // Salvar no localStorage
            document.getElementById('btn-save').addEventListener('click', () => {
                const data = { tables, nextId };
                localStorage.setItem('dbflow_fixed', JSON.stringify(data));
                //alert('Diagrama salvo no navegador!');
            });

            // Download JSON
            document.getElementById('btn-download').addEventListener('click', () => {
                const data = { tables, nextId };
                const jsonStr = JSON.stringify(data, null, 2);
                const blob = new Blob([jsonStr], { type: 'application/json' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = `diagrama-${new Date().toISOString().slice(0,10)}.json`;
                a.click();
                URL.revokeObjectURL(url);
            });

            // Upload JSON
            const fileInput = document.getElementById('file-input');
            document.getElementById('btn-upload').addEventListener('click', () => {
                fileInput.click();
            });

            fileInput.addEventListener('change', (e) => {
                const file = e.target.files[0];
                if (!file) return;

                const reader = new FileReader();
                reader.onload = (e) => {
                    try {
                        const data = JSON.parse(e.target.result);
                        if (data.tables && Array.isArray(data.tables)) {
                            tables = data.tables;
                            nextId = data.nextId || 1;
                            selectedTableId = null;
                            redraw();
                            //alert('Diagrama importado com sucesso!');
                        } else {
                            //alert('Arquivo JSON inválido: não contém tabelas');
                        }
                    } catch (err) {
                        //alert('Erro ao ler arquivo: ' + err.message);
                    }
                };
                reader.readAsText(file);
                fileInput.value = '';
            });

            // Carregar do localStorage
            document.getElementById('btn-load').addEventListener('click', () => {
                const raw = localStorage.getItem('dbflow_fixed');
                if (raw) {
                    try {
                        const data = JSON.parse(raw);
                        tables = data.tables || [];
                        nextId = data.nextId || 1;
                        selectedTableId = null;
                        redraw();
                        //alert('Diagrama carregado do navegador!');
                    } catch (err) {
                        //alert('Erro ao carregar dados salvos');
                    }
                } else {
                    //alert('Nenhum salvamento encontrado');
                }
            });

            // MODAL - Salvar alterações (CORRIGIDO)
            document.getElementById('modal-save').addEventListener('click', function() {
                console.log('Salvando alterações para tabela', editingTableId);
                
                if (editingTableId) {
                    const table = tables.find(t => t.id === editingTableId);
                    if (table) {
                        // Salvar dados básicos
                        table.name = modalName.value.trim() || 'sem nome';
                        table.columns = modalColumns.value.trim() || 'coluna';
                        
                        // Coletar relacionamentos do modal
                        const relationItems = document.querySelectorAll('.relation-item');
                        const newRelations = [];
                        
                        relationItems.forEach((item, index) => {
                            const targetSelect = item.querySelector('.relation-target');
                            const typeRadio = item.querySelector(`input[name="rel-type-${index}"]:checked`);
                            const fieldInput = item.querySelector('.relation-field');
                            
                            if (targetSelect && targetSelect.value) {
                                newRelations.push({
                                    targetTableId: parseInt(targetSelect.value),
                                    type: typeRadio ? typeRadio.value : '1:N',
                                    field: fieldInput ? fieldInput.value : 'id_relacionado'
                                });
                            }
                        });
                        
                        table.relations = newRelations;
                        console.log('Tabela atualizada:', table);
                    }
                }
                
                modal.style.display = 'none';
                editingTableId = null;
                redraw();
            });

            // MODAL - Cancelar (CORRIGIDO)
            document.getElementById('modal-cancel').addEventListener('click', function() {
                console.log('Cancelando edição');
                modal.style.display = 'none';
                editingTableId = null;
            });

            // Fechar modal com ESC
            window.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && modal.style.display === 'flex') {
                    console.log('ESC pressionado, fechando modal');
                    modal.style.display = 'none';
                    editingTableId = null;
                }
            });

 // Tabelas iniciais de exemplo
  /*
			tables.push({ 
                id: nextId++, 
                x: 200, y: 200, 
                name: 'usuarios', 
                columns: 'id INT PK\nnome VARCHAR(100)\nemail UNIQUE',
                relations: [
                    { targetTableId: 2, type: '1:N', field: 'usuario_id' }
                ]
            });
            
            tables.push({ 
                id: nextId++, 
                x: 550, y: 350, 
                name: 'pedidos', 
                columns: 'id INT PK\nusuario_id INT\ntotal DECIMAL\nstatus VARCHAR',
                relations: []
            });
            
            tables.push({ 
                id: nextId++, 
                x: 400, y: 80, 
                name: 'produtos', 
                columns: 'id INT PK\nnome VARCHAR\npreco DECIMAL\nestoque INT',
                relations: []
            });
*/
			const raw = localStorage.getItem('dbflow_fixed');
			if (raw) {
				try {
					const data = JSON.parse(raw);
					tables = data.tables || [];
					nextId = data.nextId || 1;
					selectedTableId = null; 
				} catch (err) {
					
				}
			}  
			
            redraw();
			
            console.log('Sistema inicializado. Modal buttons:', {
                save: document.getElementById('modal-save'),
                cancel: document.getElementById('modal-cancel')
            });
        })();
    </script>
</body>
</html>
