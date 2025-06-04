EXERCÍCIO FUNCTION 
ALUNA: ISYS NAILA SANTOS SILVA      RA:16424


--Crie uma FUNCTION de nome “contagem_conta” que retorne o número total de contas que determinado cliente possui, a partir do código do cliente (parâmetro da função).  


CREATE OR REPLACE FUNCTION contagem_conta (codcli CHAR(4))
RETURNS INTEGER
LANGUAGE plpgsql AS $$
DECLARE 
        total_conta INTEGER;
BEGIN
        SELECT COUNT(*) INTO total_conta FROM conta WHERE codcliente=contagem_conta.codcli;
RETURN total_conta;
end;
$$


--Selecione o nome, a cidade, o estado e o número total de contas bancárias dos clientes cadastrados.


SELECT cliente.nomeCliente, cliente.cidadeCliente, cliente.estadoCliente, contagem_conta(cliente.codCliente)
AS total_contas
FROM cliente;


--Crie uma FUNCTION de nome “total_contas” que retorne o número total de contas que determinada Agência possui, a partir do código da agência (parâmetro da função).  


CREATE OR REPLACE FUNCTION total_contas (cod_agencia CHAR(5))
RETURNS INTEGER
LANGUAGE plpgsql AS $$
DECLARE 
        total_c INTEGER;
BEGIN
        SELECT COUNT(*) INTO total_c FROM conta WHERE codAgencia=total_contas.cod_agencia;
RETURN total_c;
end;
$$


--Selecione o nome e a cidade das Agências cujo total de contas cadastradas seja maior ou igual a 2.


SELECT agencia.nomeAgencia, agencia.cidadeAgencia
FROM agencia
WHERE total_contas(agencia.codAgencia)>=2;


--Crie uma FUNCTION de nome “saldo_total_cliente” que retorne o somatório dos saldos de todas as contas que cada cliente possui, a partir do código do cliente (parâmetro da função).


CREATE OR REPLACE FUNCTION saldo_total_cliente (codcli CHAR(4))
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql AS $$
DECLARE
        saldo_total NUMERIC(10,2);
BEGIN
        SELECT SUM(saldo) INTO saldo_total FROM conta WHERE codCliente=saldo_total_cliente.codcli;
RETURN saldo_total;
end;
$$


--Selecione o nome, a cidade, o estado e o saldo total de todos os clientes.


SELECT cliente.nomeCliente, cliente.estadoCliente,cliente.cidadeCliente, saldo_total_cliente(cliente.codCliente) AS saldo_total
FROM cliente


--Selecione o nome, a cidade, o estado e o saldo total do(a) cliente com código ‘0111’.


SELECT cliente.nomeCliente, cliente.estadoCliente,cliente.cidadeCliente, saldo_total_cliente(cliente.codCliente) AS saldo_total
FROM cliente
WHERE codCliente='0111'


--Selecione o nome, a cidade, o estado e o saldo total dos clientes cujo saldo total seja maior que cem mil (100000.00).


SELECT cliente.nomeCliente, cliente.estadoCliente,cliente.cidadeCliente
FROM cliente
WHERE saldo_total_cliente(cliente.codCliente)>100000


--Crie uma FUNCTION de nome “maximo_saldo” que retorne o maior valor de saldo em conta existente em cada agência, a partir do código da agência (parâmetro da função)


CREATE FUNCTION maximo_saldo (cod_agencia CHAR(5))
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql AS $$
DECLARE
        maior_saldo NUMERIC(10,2);
BEGIN
        SELECT MAX(saldo) INTO maior_saldo FROM conta WHERE codAgencia=maximo_saldo.cod_agencia;
RETURN maior_saldo;
end;
$$


--Selecione o nome e a cidade da agência bem como o nome do cliente que possui o maior saldo e o valor do maior saldo, agrupados por agência e ordenados pelo valor do saldo, do maior para o menor. 


SELECT agencia.nomeAgencia, agencia.cidadeAgencia, cliente.nomeCliente,conta.saldo
FROM agencia
JOIN conta
ON agencia.codAgencia=conta.codAgencia
JOIN cliente
ON conta.codCliente=cliente.codCliente
WHERE conta.saldo=maximo_saldo(agencia.codAgencia)
ORDER BY conta.saldo DESC


--Crie uma FUNCTION de nome “minimo_saldo” que retorne o menor valor de saldo em conta existente em cada agência, a partir do código da agência (parâmetro da função).


CREATE FUNCTION minimo_saldo (cod_agencia CHAR(5))
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql AS $$
DECLARE
        menor_saldo NUMERIC(10,2);
BEGIN
        SELECT MIN(saldo) INTO menor_saldo FROM conta WHERE codAgencia=minimo_saldo.cod_agencia;
RETURN menor_saldo;
end;
$$
         
--Selecione o nome e a cidade da agência bem como o nome do cliente que possui o menor saldo e o valor do menor saldo, agrupados por agência e ordenados pelo valor do saldo, do menor para o maior.


SELECT agencia.nomeAgencia, agencia.cidadeAgencia, cliente.nomeCliente,conta.saldo
FROM agencia
JOIN conta
ON agencia.codAgencia=conta.codAgencia
JOIN cliente
ON conta.codCliente=cliente.codCliente
WHERE conta.saldo=minimo_saldo(agencia.codAgencia)
ORDER BY conta.saldo ASC
