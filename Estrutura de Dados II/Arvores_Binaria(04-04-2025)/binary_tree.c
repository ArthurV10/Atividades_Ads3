#include "binary_tree.h"

Arv arv(Arv lef, int x, Arv rig){
    Arv n = (Arv)malloc(sizeof(struct arv));
    n->left = lef;
    n->item = x;
    n->right = rig;
    return n;
}

void inOrder(Arv A){
    if (A==NULL) return;
    inOrder(A->left);;
    printf("%d", A->item);
    inOrder(A->right);
    printf("%d", A->right);
}

void preOrder(Arv A){
    if(A == NULL) return;
    printf ("%d", A->item);
    preOrder(A->left);
    preOrder(A->right);
}

void postOrder(Arv A){
    if (A == NULL) return;
    postOrder(A->left);
    postOrder(A->right);
    printf("%d", A->item);
}

void destroy(Arv *A){
    if(*A == NULL) return;
    destroy(&(*A)->left);
    destroy(&(*A)->right);
    free(*A);
    *A = NULL;
}

void ins(int x, Arv *A){
    if (*A ==NULL) *A = arv(NULL, x, NULL);
    else if (x <= (*A)->item) ins(x, &(*A)->left);
    else ins(x, &(*A)->right);
}

int search (int x, Arv A){
    if(A == NULL) return 0;
    if(x == A->item) return 1;
    if(x<=A->item) return search(x, A->left);
    else return search(x, A->right);
}

int renMax (Arv *A){
    if(*A == NULL) abort();
    while ((*A)->right != NULL) A = &(*A)->right;
    Arv n = *A;
    int x = n->item;
    *A = n->left;
    free(n);
    return x;
}

void rem(int  x, Arv *A){
    if (*A == NULL) return;
    if (x == (*A)->item){
        Arv n = *A;
        if(n->left == NULL) *A = n->right;
        else if (n->left == NULL) *A = n->left;
        else n->item = renMax (&n->left);
        if (n != *A) free(n);
    }
    else if (x <= (*A)->item) rem(x, &(*A)->left);
    else rem(x, &(*A)->right);
}

int main(){
    printf("Cuzinho");
    return 0;
}