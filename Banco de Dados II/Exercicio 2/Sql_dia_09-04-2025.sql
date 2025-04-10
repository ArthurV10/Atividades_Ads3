/* Questão 1:  Listagem dos hóspedes contendo nome e data de nascimento,
   ordenada em ordem crescente por nome e decrescente por data de nascimento.
*/

SELECT NOME, DATA_NASC FROM HOSPEDE ORDER BY NOME ASC, DATA_NASC DESC;

/* Questão 2: Listagem contendo os nomes das categorias,
   ordenados alfabeticamente. A coluna de nomes deve ter a palavra
  ‘Categoria’ como título 
*/

SELECT NOME AS "Categoria" FROM CATEGORIA  ORDER BY NOME;

/*Questão 3: Listagem contendo 
os valores de diárias e os números dos apartamentos, 
ordenada em ordem decrescente de valor.
*/
