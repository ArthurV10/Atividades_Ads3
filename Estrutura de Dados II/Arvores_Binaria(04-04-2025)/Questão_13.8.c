#include <stdio.h>
#include <stdlib.h>
#include "binary_tree.h"

// Função que avalia a expressão aritmética representada pela árvore
int valor(ArvChar A) {
    if (A == NULL) return 0;

    // Folha: retorna o valor diretamente
    if (A->left == NULL && A->right == NULL)
        return A->item;

    int esq = valor(A->left);
    int dir = valor(A->right);

    switch (A->item) {
        case '+': return esq + dir;
        case '-': return esq - dir;
        case '*': return esq * dir;
        case '/': return esq / dir;
        default: return 0;
    }
}

int main() {
    // Expressão: ((9 + 3) / 2) * (11 - 1)
    ArvChar A =
        nodeChar(
            nodeChar(
                nodeChar(
                    node(NULL, 9, NULL),
                    '+',
                    node(NULL, 3, NULL)
                ),
                '/',
                node(NULL, 2, NULL)
            ),
            '*',
            nodeChar(
                node(NULL, 11, NULL),
                '-',
                node(NULL, 1, NULL)
            )
        );

    int resultado = valor(A);
    printf("Resultado da expressao: %d\n", resultado); // Esperado: 60

    destroy(&A);
    return 0;
}
