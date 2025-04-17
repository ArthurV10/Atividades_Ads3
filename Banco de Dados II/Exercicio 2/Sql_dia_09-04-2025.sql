/* Questão 1:  Listagem dos hóspedes contendo nome e data de nascimento,
   ordenada em ordem crescente por nome e decrescente por data de nascimento.
*/

SELECT NOME, DT_NASC FROM HOSPEDE ORDER BY NOME ASC, DT_NASC DESC;

/* Questão 2: Listagem contendo os nomes das categorias,
   ordenados alfabeticamente. A coluna de nomes deve ter a palavra
  ‘Categoria’ como título 
*/

SELECT NOME AS "Categoria" FROM CATEGORIA  ORDER BY NOME;

/*Questão 3: Listagem contendo 
os valores de diárias e os números dos apartamentos, 
ordenada em ordem decrescente de valor.
*/

SELECT NUM_AP AS "APARTAMENTO", PRECO AS "PREÇO" FROM 
CATEGORIA CAT JOIN APARTAMENTO APTO
ON CAT.COD_CAT = APTO.COD_CAT ORDER BY PRECO DESC;

/* Questão 4: Categorias que possuem apenas um apartamento.
*/

SELECT NOME, COUNT(APTO.NUM_AP) 
FROM CATEGORIA CAT 
JOIN APARTAMENTO APTO ON APTO.COD_CAT = CAT.COD_CAT 
GROUP BY CAT.NOME 
HAVING COUNT(APTO.NUM_AP) = 1
ORDER BY CAT.NOME;

/* Questão 5: Listagem dos nomes dos hóspedes brasileiros com mês e ano de nascimento, por ordem 
decrescente de idade e por ordem crescente de nome do hóspede.
*/

SELECT NOME, EXTRACT (MONTH FROM DT_NASC) MES, 
EXTRACT (YEAR FROM DT_NASC) ANO FROM HOSPEDE WHERE
NAC ILIKE 'Brasileiro' ORDER BY DT_NASC DESC;

/* Questão 6: Listagem com 3 colunas, nome do hóspede, número do apartamento e quantidade
(número de vezes que aquele hóspede se hospedou naquele apartamento), 
em ordem decrescente de quantidade. 
*/

SELECT NOME, NUM_AP, HOSPEDAGEM.COD_HOSP, COUNT(*) AS HOSPEDAGENS FROM HOSPEDAGEM 
JOIN HOSPEDE ON HOSPEDE.COD_HOSP = HOSPEDAGEM.COD_HOSP
GROUP BY NOME, NUM_AP, HOSPEDAGEM.COD_HOSP ORDER BY HOSPEDAGENS DESC;

SELECT * FROM HOSPEDAGEM;

INSERT INTO HOSPEDAGEM VALUES(16, 5, 2, 2, '2025-12-02', '2026-12-02');
INSERT INTO HOSPEDAGEM VALUES(17, 5, 2, 2, '2024-12-02', '2027-12-02');

