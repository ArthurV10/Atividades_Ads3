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

/* Questão 7:  Categoria cujo nome tenha comprimento superior a 15 caracteres. 
*/

SELECT NOME FROM CATEGORIA WHERE LENGTH(NOME) > 15;

/* Questão 8: Número dos apartamentos ocupados no ano de 2017 com o respectivo nome da sua 
categoria.  
*/

SELECT HOSP.NUM_AP, NOME FROM APARTAMENTO APTO
JOIN CATEGORIA CAT ON APTO.COD_CAT = CAT.COD_CAT
JOIN HOSPEDAGEM HOSP ON HOSP.NUM_AP = APTO.NUM_AP
WHERE DT_ENT BETWEEN '2017-01-01' AND '2017-12-31';

/* Questão 10: Crie a tabela funcionário com as atributos: cod_func, nome, dt_nascimento e salário. 
Depois disso, acrescente o cod_func como chave estrangeira nas tabelas hospedagem e 
reserva.  
*/

-- Está tudo feito dentro de SOURCE_CODE (GITHUB) -- 

/* Questão 11:  Mostre o nome e o salário de cada funcionário.  Extraordinariamente, cada funcionário 
receberá um acréscimo neste salário de 10 reais para cada hospedagem realizada. 
*/

SELECT FUNC.NOME, FUNC.SALARIO + (10 * COUNT(*)) AS "Salario Final"
FROM FUNCIONARIO FUNC 
LEFT JOIN HOSPEDAGEM HOSP ON FUNC.COD_FUNC = HOSP.COD_FUNC
GROUP BY FUNC.NOME, FUNC.SALARIO;

/* Questão 12: Listagem das categorias cadastradas e para aquelas que possuem apartamentos, relacionar 
também o número do apartamento, ordenada pelo nome da categoria e pelo número do 
apartamento. 
*/

SELECT CAT.NOME, APTO.NUM_AP 
FROM CATEGORIA CAT
LEFT JOIN APARTAMENTO APTO ON CAT.COD_CAT = APTO.COD_CAT
ORDER BY CAT.NOME, APTO.NUM_AP;

/* Questão 13:  Listagem das categorias cadastradas e para aquelas que possuem apartamentos, relacionar 
também o número do apartamento, ordenada pelo nome da categoria e pelo número do 
apartamento. Para aquelas que não possuem apartamentos associados, escrever "não possui 
apartamento". 
*/

SELECT CAT.NOME AS CATEGORIA, 
COALESCE(CAST(APTO.NUM_AP AS VARCHAR), 'Não possui apartamento') AS APARTAMENTO
FROM CATEGORIA CAT
LEFT JOIN APARTAMENTO APTO ON CAT.COD_CAT = APTO.COD_CAT
ORDER BY CAT.NOME, APTO.NUM_AP;

/* Questão 14: O nome dos funcionário que atenderam o João (hospedando ou reservando) ou que 
hospedaram ou reservaram apartamentos da categoria luxo.  
*/

SELECT DISTINCT FUNC.NOME FROM FUNCIONARIO FUNC
JOIN HOSPEDAGEM HOSPEDA ON FUNC.COD_FUNC = HOSPEDA.COD_FUNC
JOIN APARTAMENTO APTO ON HOSPEDA.NUM_AP = APTO.NUM_AP
JOIN CATEGORIA CAT ON APTO.COD_CAT = CAT.COD_CAT
JOIN HOSPEDE HOSP ON HOSPEDA.COD_HOSP = HOSP.COD_HOSP
WHERE HOSP.NOME = 'João' 
OR CAT.NOME = 'Luxo';

/* Questão 15: O código das hospedagens realizadas pelo hóspede mais velho que se hospedou no 
apartamento mais caro. 
*/

SELECT HOSPEDA.COD_HOSPEDAGEM
FROM HOSPEDAGEM HOSPEDA
JOIN HOSPEDE HOSP ON HOSP.COD_HOSP = HOSPEDA.COD_HOSP
JOIN APARTAMENTO APTO ON HOSPEDA.NUM_AP = APTO.NUM_AP
JOIN CATEGORIA CAT ON APTO.COD_CAT = CAT.COD_CAT
WHERE CAT.PRECO = (
    SELECT MAX(PRECO) FROM CATEGORIA
)
AND HOSP.DT_NASC = (
    SELECT MIN(HOSP2.DT_NASC)
    FROM HOSPEDE HOSP2
    JOIN HOSPEDAGEM HOSPEDA2 ON HOSP2.COD_HOSP = HOSPEDA2.COD_HOSP
    JOIN APARTAMENTO APTO2 ON HOSPEDA2.NUM_AP = APTO2.NUM_AP
    JOIN CATEGORIA CAT2 ON APTO2.COD_CAT = CAT2.COD_CAT
    WHERE CAT2.PRECO = (
        SELECT MAX(PRECO) FROM CATEGORIA
    )
);

/* Questão 16:  Sem usar subquery, o nome dos hóspedes que nasceram na mesma data do hóspede de 
código 2. */

SELECT H1.NOME
FROM HOSPEDE H1
JOIN HOSPEDE H2 ON H1.DT_NASC = H2.DT_NASC
WHERE H2.COD_HOSP = 2
AND H1.COD_HOSP <> 2;

/* Questão 17: O nome do hóspede mais velho que se hospedou na categoria mais cara no ano de 2017.
*/

SELECT HOSP.NOME
FROM HOSPEDE HOSP
WHERE HOSP.DT_NASC = (
    SELECT MIN(HOSP2.DT_NASC)
    FROM HOSPEDE HOSP2
    JOIN HOSPEDAGEM HOSPEDA2 ON HOSP2.COD_HOSP = HOSPEDA2.COD_HOSP
    JOIN APARTAMENTO APTO2 ON HOSPEDA2.NUM_AP = APTO2.NUM_AP
    JOIN CATEGORIA CAT2 ON APTO2.COD_CAT = CAT2.COD_CAT
    WHERE HOSPEDA2.DT_ENT BETWEEN '2017-01-01' AND '2017-12-31'
    AND CAT2.PRECO = (SELECT MAX(PRECO) FROM CATEGORIA)
)

/* Questão 18: O nome das categorias que foram reservadas pela Maria ou que foram 
ocupadas pelo João quando ele foi atendido pelo Joaquim. */

SELECT DISTINCT CAT.NOME
FROM CATEGORIA CAT
JOIN APARTAMENTO APTO ON APTO.COD_CAT = CAT.COD_CAT
JOIN HOSPEDAGEM HOSPEDA ON HOSPEDA.NUM_AP = APTO.NUM_AP
JOIN HOSPEDE HOSP ON HOSP.COD_HOSP = HOSPEDA.COD_HOSP
JOIN FUNCIONARIO FUNC ON FUNC.COD_FUNC = HOSPEDA.COD_FUNC
WHERE HOSP.NOME ILIKE 'Maria'
OR (HOSP.NOME ILIKE 'João' AND FUNC.NOME ILIKE 'Joaquim');

/* Questão 19: O nome e a data de nascimento dos funcionários, além do valor de diária mais cara 
reservado por cada um deles. 
*/

SELECT FUNC.NOME, FUNC.DT_NASC, MAX(PRECO) FROM FUNCIONARIO FUNC
JOIN HOSPEDAGEM HOSPEDA ON HOSPEDA.COD_FUNC = FUNC.COD_FUNC
JOIN APARTAMENTO APTO ON APTO.NUM_AP = HOSPEDA.NUM_AP
JOIN CATEGORIA CAT ON CAT.COD_CAT = APTO.COD_CAT
GROUP BY FUNC.NOME, FUNC.DT_NASC;

/* Questão 20: A quantidade de apartamentos ocupados por cada um dos hóspedes (mostrar o nome)
*/

SELECT NOME, COUNT(*) FROM HOSPEDE HOSP
JOIN HOSPEDAGEM HOSPEDA ON HOSPEDA.COD_HOSP = HOSP.COD_HOSP
GROUP BY NOME, HOSPEDA.COD_HOSP;

/* Questão 21: A relação com o nome dos hóspedes, a data de entrada, 
a data de saída e o valor total pago em diárias 
(não é necessário considerar a hora de entrada e saída, apenas as datas)
*/

SELECT HOSP.NOME, HOSPEDA.DT_ENT, HOSPEDA.DT_SAIDA,
(CAT.PRECO * (HOSPEDA.DT_SAIDA - HOSPEDA.DT_ENT)) AS VALOR_TOTAL
FROM HOSPEDE HOSP
JOIN HOSPEDAGEM HOSPEDA ON HOSP.COD_HOSP = HOSPEDA.COD_HOSP
JOIN APARTAMENTO APTO ON HOSPEDA.NUM_AP = APTO.NUM_AP
JOIN CATEGORIA CAT ON APTO.COD_CAT = CAT.COD_CAT;

/* Questão 22:  O nome dos hóspedes que já se hospedaram em todos os apartamentos do hotel. 
*/

SELECT HOSP.NOME
FROM HOSPEDE HOSP
JOIN HOSPEDAGEM HOSPEDA ON HOSP.COD_HOSP = HOSPEDA.COD_HOSP
GROUP BY HOSP.COD_HOSP, HOSP.NOME
HAVING COUNT(DISTINCT HOSPEDA.NUM_AP) = (
    SELECT COUNT(*) FROM APARTAMENTO
);

