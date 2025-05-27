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