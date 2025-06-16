function getById(id) {
    return document.getElementById(id);
}

function getBotaoClicavel(id, funcao) {
    getById(id).addEventListener('click', funcao);
    return getById(id);
}

let botaoCriarParagrafo = 
    getBotaoClicavel('botaoCriarParagrafo', criarParagrafo);

function criarParagrafo() {
    //crio o elemento
    let p1 = document.createElement('p');
    //configuro o elemento
    p1.innerText = "Hello world 2";
    p1.id = 'p1';
    //p1.setAttribute('id', 'p1'); equivalente à instrução acima

    //associo ao parent
    getById('resultado1').appendChild(p1);
}


let botaoCriarElemento = 
        getBotaoClicavel('botaoCriarElemento', criarElemento);

function criarElemento() {
    let tagElemento = getById('tagElemento').value;

    //crio o elemento
    let elemento = document.createElement(tagElemento);
    
    //configuro o elemento
    elemento.id = getById('id').value;
    elemento.innerText = getById('texto').value;
    elemento.setAttribute(getById('atributo').value, getById('valor').value);
    
    //associo ao parent
    let pai = getById('pai').value;
    getById(pai).appendChild(elemento);
}


let botaoAdicionarTarefa = 
        getBotaoClicavel('botaoAdicionarTarefa', adicionarTarefa);

let contador = 1;

function adicionarTarefa() {
    let descricao = getById('descricao').value;
    let percentual = getById('percentual').value;

    //crio a linha
    let tr = document.createElement('tr');
    tr.id = contador;

    //crio as colunas
    //contador
    let tdContador = document.createElement('td');
    tdContador.innerText = contador;
    //descricao
    let tdDescricao = document.createElement('td');
    tdDescricao.innerText = descricao;
    //percentual
    let tdPercentual = document.createElement('td');
    tdPercentual.innerText = percentual + "%";
    //ações
    let tdAcoes = document.createElement('td');
    let botaoExcluir = document.createElement('button');
    botaoExcluir.innerText = 'Excluir';
    tdAcoes.appendChild(botaoExcluir);

    tr.appendChild(tdContador);
    tr.appendChild(tdDescricao);
    tr.appendChild(tdPercentual);
    tr.appendChild(tdAcoes);

    contador++;

    getById('tarefas').appendChild(tr);
}        

