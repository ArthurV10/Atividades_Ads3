// Altera o texto ao apertar botão - codigo questão 2
function mudarTexto(){
    let botaoAlterar = document.getElementById("botao-alterar");
    
    if (botaoAlterar.textContent === "Aperte!"){
        botaoAlterar.textContent = "Não Aperte!";
    }
    else {
        botaoAlterar.textContent = "Aperte!";
    }
}

// Conta a quantidade de elementos paragrafos - questão 3
function mostrarParagrafo(){
  const paragrafos = document.getElementsByTagName("p");
  const total = paragrafos.length;

  for (let i = 1; i <= total; i++) {
    setTimeout(function(){
      document.getElementById("qtd-paragrafo").textContent =
        "Quantidade de Parágrafos: " + i;
    }, 150 * i);
  }
}

// Apagar conteudo do texto - questão 4
function apagarTexto(){
    var botao = document.getElementById("paragrafo-apagar");
    botao.textContent = "";
}

var botaoApagar = document.getElementById("botao-apagar");

botaoApagar.addEventListener("click", function() {
    var apagarBotao = document.getElementById("botao-apagar");
    let i = 3;

    var intervalo = setInterval(function() {
        if (i > 0) {
            apagarBotao.textContent = "O parágrafo deste texto será apagado em " + i;
            i--;
        } else {
            apagarBotao.textContent = "Parágrafo apagado!"
            clearInterval(intervalo);
            apagarTexto();
        }
    }, 1000); 
});

// Script para colocar as cores de acordo com o input de cores no html, alterando CSS - Questão 6

const colorPicker = document.getElementById("colorPicker");
const colorValue  = document.getElementById("colorValue");
const preview     = document.getElementById("previewBox");

colorPicker.addEventListener("input", function() {
    const cor = this.value;            // ex.: "#ff8800"
    colorValue.textContent = cor;      // mostra o hex ao lado
    preview.style.backgroundColor = cor; 
    preview.textContent = `Cor de fundo: ${cor}`;

    preview.style.color = (parseInt(cor.slice(1),16) > 0xffffff/2) ? '#000' : '#fff';
});

// Codigo para copiar o codigo em caixa alta - Questão 7
const origem  = document.getElementById("origem");
const destino = document.getElementById("destino");

function copiarTextoCaixaAlta() {
    const texto = origem.value;
    destino.value = texto.toUpperCase();
}

origem.addEventListener("input", copiarTextoCaixaAlta);

// Alterar cores do HTML por meio do botão - Questão 8
const body = document.body;
const corFundoOriginal = getComputedStyle(body).backgroundColor;
const corTextoOriginal = getComputedStyle(body).color;

let modoContraste = false;

function alterarModo() {
    if (!modoContraste) {
        body.style.backgroundColor = "black";
        body.style.color = "white";
        modoContraste = true;
    } else {
        // Volta para as cores originais salvas
        body.style.backgroundColor = "white";
        body.style.color = "black";
        modoContraste = false;
    }
}

function resetarCores() {
    body.style.backgroundColor = corFundoOriginal;
    body.style.color = corTextoOriginal;
    modoContraste = false;
}

// Aumenta e diminui o tamanho das letras do body - Questão 9
let tamanhoFonteAtual = parseFloat(getComputedStyle(body).fontSize);
const tamanhoFonteOriginal = parseFloat(getComputedStyle(body).fontSize);

// Define o incremento (em pixels)
const incremento = 2;

function aumentarTexto() {
    tamanhoFonteAtual += incremento;
    body.style.fontSize = tamanhoFonteAtual + "px";
}

function diminuirTexto() {
    tamanhoFonteAtual -= incremento;
    // Define um tamanho mínimo para evitar texto ilegível
    if (tamanhoFonteAtual < 8) {
        tamanhoFonteAtual = 8;
    }
    body.style.fontSize = tamanhoFonteAtual + "px";
}

function resetarTexto() {
    body.style.fontSize = tamanhoFonteOriginal + "px";
}

// Calculadora no HTML - Questão 10
function calcular() {
    const n1 = parseFloat(document.getElementById("num1").value);
    const n2 = parseFloat(document.getElementById("num2").value);

    const operacoes = document.getElementsByName("operacao");
    let operacaoSelecionada = null;

    // Descobre qual radio está selecionado
    for (let i = 0; i < operacoes.length; i++) {
        if (operacoes[i].checked) {
            operacaoSelecionada = operacoes[i].value;
            break;
        }
    }

    let resultado;

    switch (operacaoSelecionada) {
        case "+":
            resultado = n1 + n2;
            break;
        case "-":
            resultado = n1 - n2;
            break;
        case "*":
            resultado = n1 * n2;
            break;
        case "/":
            if (n2 !== 0) {
                resultado = n1 / n2;
            } else {
                resultado = "Erro: Divisão por zero!";
            }
            break;
        default:
            resultado = "Selecione uma operação.";
    }

    document.getElementById("resultado").textContent = "Resultado: " + resultado;
}

// Adicionar item na lista - Questão 11
function adicionarNaLista() {
    const texto = document.getElementById("caixaTexto").value;

    if (texto.trim() === "") {
        alert("Digite algo antes de adicionar!");
        return;
    }

    const novoItem = document.createElement("li");

    novoItem.textContent = texto;

    const lista = document.getElementById("lista");
    lista.appendChild(novoItem);

    document.getElementById("caixaTexto").value = "";
}

function apagarLista(){
    const lista = document.getElementById("lista");
    
    while (lista.firstChild) {
        lista.removeChild(lista.firstChild); 
    }
}

// Adicionar itens no select, para permitir seleção - Questão 12
function adicionarNoSelect() {
    const texto = document.getElementById("caixaTextoSelect").value;

    if (texto.trim() === "") {
        alert("Digite algo antes de adicionar!");
        return;
    }

    const novaOpcao = document.createElement("option");

    novaOpcao.textContent = texto;
    novaOpcao.value = texto;

    const select = document.getElementById("meuSelect");
    select.appendChild(novaOpcao);

    document.getElementById("caixaTextoSelect").value = "";
}

function apagarNoSelect(){
    const select = document.getElementById("meuSelect");

    while (select.children.length > 1) { 
        select.removeChild(select.children[1]);
    }
}
