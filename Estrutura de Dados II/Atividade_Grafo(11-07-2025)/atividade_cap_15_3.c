#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Estrutura para o nó da lista de adjacência
struct No {
    int destino;
    struct No* proximo;
};

// Estrutura para o grafo
struct Grafo {
    int numVertices;
    struct No** listasDeAdjacencia;
};

// --- Funções básicas do Grafo (criação e adição de arestas) ---

struct No* criarNo(int destino) {
    struct No* novoNo = (struct No*) malloc(sizeof(struct No));
    novoNo->destino = destino;
    novoNo->proximo = NULL;
    return novoNo;
}

struct Grafo* criarGrafo(int V) {
    struct Grafo* grafo = (struct Grafo*) malloc(sizeof(struct Grafo));
    grafo->numVertices = V;
    grafo->listasDeAdjacencia = (struct No**) malloc(V * sizeof(struct No*));
    for (int i = 0; i < V; i++) {
        grafo->listasDeAdjacencia[i] = NULL;
    }
    return grafo;
}

void adicionarAresta(struct Grafo* grafo, int origem, int destino) {
    struct No* novoNo = criarNo(destino);
    novoNo->proximo = grafo->listasDeAdjacencia[origem];
    grafo->listasDeAdjacencia[origem] = novoNo;
}

// --- Fim das funções básicas do Grafo ---


// Função auxiliar para imprimir um caminho encontrado
void imprimirCaminho(int caminho[], int tamanho) {
    for (int i = 0; i < tamanho; i++) {
        printf("%d", caminho[i]);
        if (i < tamanho - 1) {
            printf(" -> ");
        }
    }
    printf("\n");
}

/*
 * Abordagem 1: Encontrando TODOS os caminhos usando Busca em Profundidade (DFS)
 * Esta é a abordagem correta para o problema de "encontrar todos os caminhos".
*/
void encontrarTodosOsCaminhos_DFS(struct Grafo* grafo, int u, int d, bool visitado[], int caminho[], int* indiceCaminho) {
    // Marca o nó atual como visitado e o adiciona ao caminho
    visitado[u] = true;
    caminho[*indiceCaminho] = u;
    (*indiceCaminho)++;

    // Se o nó atual é o destino, imprime o caminho
    if (u == d) {
        imprimirCaminho(caminho, *indiceCaminho);
    } else {
        // Se não for o destino, percorre todos os seus vizinhos
        struct No* adj = grafo->listasDeAdjacencia[u];
        while (adj != NULL) {
            int v = adj->destino;
            if (!visitado[v]) {
                encontrarTodosOsCaminhos_DFS(grafo, v, d, visitado, caminho, indiceCaminho);
            }
            adj = adj->proximo;
        }
    }

    // Remove o nó atual do caminho e o marca como não visitado (backtracking)
    (*indiceCaminho)--;
    visitado[u] = false;
}

/*
 * Abordagem 2: Encontrando o CAMINHO MAIS CURTO usando Busca em Largura (BFS)
 * Esta é a aplicação padrão da função bfs().
*/
void encontrarCaminhoMaisCurto_BFS(struct Grafo* grafo, int inicio, int fim) {
    int numVertices = grafo->numVertices;
    // Fila para o BFS
    int* fila = (int*)malloc(numVertices * sizeof(int));
    int frente = 0, tras = 0;

    // Arrays para controle
    bool* visitado = (bool*)calloc(numVertices, sizeof(bool));
    int* pai = (int*)malloc(numVertices * sizeof(int));
    for(int i=0; i<numVertices; i++) pai[i] = -1;

    // Inicia o BFS
    visitado[inicio] = true;
    fila[tras++] = inicio;

    bool encontrado = false;
    while (frente < tras) {
        int u = fila[frente++];
        if (u == fim) {
            encontrado = true;
            break; // Encontrou o destino pelo caminho mais curto
        }

        struct No* adj = grafo->listasDeAdjacencia[u];
        while(adj != NULL) {
            int v = adj->destino;
            if (!visitado[v]) {
                visitado[v] = true;
                pai[v] = u; // Guarda o "pai" do nó para reconstruir o caminho
                fila[tras++] = v;
            }
            adj = adj->proximo;
        }
    }

    // Se encontrou, reconstrói e imprime o caminho
    if (encontrado) {
        int* caminho = (int*)malloc(numVertices * sizeof(int));
        int indiceCaminho = 0;
        int atual = fim;
        while(atual != -1) {
            caminho[indiceCaminho++] = atual;
            atual = pai[atual];
        }

        // Imprime o caminho na ordem correta (início -> fim)
        for (int i = indiceCaminho - 1; i >= 0; i--) {
            printf("%d", caminho[i]);
            if (i > 0) {
                printf(" -> ");
            }
        }
        printf("\n");
        free(caminho);
    } else {
        printf("Nenhum caminho encontrado de %d a %d.\n", inicio, fim);
    }
    
    free(fila);
    free(visitado);
    free(pai);
}


int main() {
    int numVertices = 6;
    struct Grafo* grafo = criarGrafo(numVertices);

    // Adicionando as arestas do grafo do Exercício 15.1
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

    int inicio = 0, fim = 5;

    // --- Executando a busca por TODOS os caminhos (DFS) ---
    printf("Exibindo TODOS os caminhos de %d a %d (usando DFS):\n", inicio, fim);
    bool* visitado_dfs = (bool*)calloc(numVertices, sizeof(bool));
    int* caminho_dfs = (int*)malloc(numVertices * sizeof(int));
    int indiceCaminho = 0;
    encontrarTodosOsCaminhos_DFS(grafo, inicio, fim, visitado_dfs, caminho_dfs, &indiceCaminho);
    
    printf("\n");

    // --- Executando a busca pelo CAMINHO MAIS CURTO (BFS) ---
    printf("Exibindo o caminho MAIS CURTO de %d a %d (usando BFS):\n", inicio, fim);
    encontrarCaminhoMaisCurto_BFS(grafo, inicio, fim);

    // Liberar memória (não mostrado para simplicidade, mas importante em projetos reais)
    free(visitado_dfs);
    free(caminho_dfs);
    // ... liberar a estrutura do grafo ...

    return 0;
}