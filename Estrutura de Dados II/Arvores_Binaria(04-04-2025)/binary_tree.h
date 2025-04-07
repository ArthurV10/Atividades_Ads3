#ifndef ARV_H
#define ARV_H

#include <stdio.h>
#include <stdlib.h>

#define fmt "%d"

// Definição da estrutura da árvore binária
typedef struct arv {
    struct arv *left;
    int item;
    struct arv *right;
} *Arv;

// Função para criar um novo nó da árvore
Arv arv(Arv lef, int x, Arv rig);

// Funções de percurso
void inOrder(Arv A);
void preOrder(Arv A);
void postOrder(Arv A);

// Função para liberar memória da árvore
void destroy(Arv *A);

// Função para inserir um elemento na árvore
void ins(int x, Arv *A);

// Função para buscar um elemento na árvore
int search(int x, Arv A);

// Função para remover o maior elemento da árvore e retornar seu valor
int renMax(Arv *A);

// Função para remover um elemento específico da árvore
void rem(int x, Arv *A);

#endif // ARV_H
