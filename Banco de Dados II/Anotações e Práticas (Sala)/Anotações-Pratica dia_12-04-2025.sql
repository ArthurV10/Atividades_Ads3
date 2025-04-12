/* Aprendendo a criar visões, 
   basicamente fazer tabelas com condições
   especificas
*/

/* Essa tabela não existe entre as tabelas, porém pode ser manipulada
   O CREATE OR REPLACE existe pois, se for apenas CREATE, caso modifique
   algo, não ira ocorrer essa modificação, 
   então o replace é para "Colocar por cima"
*/

CREATE OR REPLACE VIEW HOSPEDE_J
AS SELECT * FROM HOSPEDE WHERE NOME ILIKE 'J%';

SELECT * FROM HOSPEDE_J;

/*Conteudo basicamente sobre view*/
