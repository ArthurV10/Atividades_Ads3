#include <stdio.h>
#include <stdlib.h>

// Estrutura para representar um nó da lista de adjacência
struct No {
    int destino;
    struct No* proximo;
};

// Estrutura para representar o grafo
struct Grafo {
    int numVertices;
    struct No** listasDeAdjacencia; // Um array de ponteiros para Nós
};

// Função para criar um novo nó da lista de adjacência
struct No* criarNo(int destino) {
    struct No* novoNo = (struct No*) malloc(sizeof(struct No));
    novoNo->destino = destino;
    novoNo->proximo = NULL;
    return novoNo;
}

// Função para criar um grafo com V vértices
struct Grafo* criarGrafo(int V) {
    struct Grafo* grafo = (struct Grafo*) malloc(sizeof(struct Grafo));
    grafo->numVertices = V;

    // Cria um array de listas de adjacência
    grafo->listasDeAdjacencia = (struct No**) malloc(V * sizeof(struct No*));

    // Inicializa cada lista de adjacência como vazia (NULL)
    for (int i = 0; i < V; i++) {
        grafo->listasDeAdjacencia[i] = NULL;
    }

    return grafo;
}

// Adiciona uma aresta direcionada de 'origem' para 'destino'
void adicionarAresta(struct Grafo* grafo, int origem, int destino) {
    // Cria um novo nó com o destino
    struct No* novoNo = criarNo(destino);
    
    // Adiciona o novo nó no início da lista de adjacência da origem
    novoNo->proximo = grafo->listasDeAdjacencia[origem];
    grafo->listasDeAdjacencia[origem] = novoNo;
}

// Função para imprimir a representação do grafo (listas de adjacência)
void imprimirGrafo(struct Grafo* grafo) {
    printf("Representação do Grafo em Listas de Adjacências:\n");
    for (int v = 0; v < grafo->numVertices; v++) {
        struct No* temp = grafo->listasDeAdjacencia[v];
        printf("adj[%d]: ", v);
        while (temp) {
            printf("-> %d ", temp->destino);
            temp = temp->proximo;
        }
        printf("\n");
    }
}

int main() {
    // O grafo possui 6 vértices (de 0 a 5)
    int numVertices = 6;
    struct Grafo* grafo = criarGrafo(numVertices);

    // Adicionando as arestas conforme a imagem
    adicionarAresta(grafo, 0, 1);
    adicionarAresta(grafo, 0, 3);
    adicionarAresta(grafo, 1, 0);
    adicionarAresta(grafo, 2, 0);
    adicionarAresta(grafo, 2, 4);
    adicionarAresta(grafo, 3, 1);
    adicionarAresta(grafo, 3, 2);
    adicionarAresta(grafo, 4, 2);
    adicionarAresta(grafo, 4, 5);
    adicionarAresta(grafo, 5, 3);

    // Imprime o grafo
    imprimirGrafo(grafo);
    
    // Libera a memória (opcional, mas boa prática)
    for (int i = 0; i < numVertices; i++) {
        struct No* atual = grafo->listasDeAdjacencia[i];
        while (atual != NULL) {
            struct No* temp = atual;
            atual = atual->proximo;
            free(temp);
        }
    }
    free(grafo->listasDeAdjacencia);
    free(grafo);

    return 0;
}