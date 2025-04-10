--Agrupa os atributos iguais --
--Caso possuem 3 nomes iguais, eles virariam 1--
select nome from hospede group by nome;

--Contar a quantidade de nomes de "group by"--
select nome,count(nome) from hospede group by nome;

--Pega todos os tipos existentes e apresenta apenas 1--
select distinct nome from hospede;

--Ordenar os valores "order by" = Existem Asc para crescente e Desc para decrescente--
select nome,count(nome) from hospede group by nome order by nome asc;

--Obter a quantidade de hospedagens realizadas por cada nome de hospede--
select nome, count(nome) from hospede h join hospedagem hosp on hosp.cod_hosp = h.cod_hosp group by nome;

--Obter para cada nome de categoria, a quantidade de hospedagens realizada--
select nome, count(nome) from categoria cat join apartamento apt on cat.cod_cat = apt.cod_cat 
join hospedagem hosp on apt.num_ap = hosp.num_ap group by nome;

--Versão variada da anterior com uma condicional no grupo--
select nome, count(nome) from categoria cat join apartamento apt on cat.cod_cat = apt.cod_cat 
join hospedagem hosp on apt.num_ap = hosp.num_ap group by nome having count(nome)=1;
