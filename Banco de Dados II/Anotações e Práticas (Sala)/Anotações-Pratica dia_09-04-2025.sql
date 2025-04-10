--Anotações Aula do dia 09/04/2025--

--Professor ensinou sobre cast--
--Pesquisar Coalesce--
--Apenas sei no momento que serve para caso o valor seja nulo mostre esse texto--
Select nome, Coalesce(Cast(NUMERO as Text), 'Não tem apto')
from categoria C LEFT JOIN APTO A ON C.COD_CAT=A.COD_CAT;


