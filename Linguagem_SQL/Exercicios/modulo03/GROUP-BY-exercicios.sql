/*
Autor: Henrique Rodrigues
Data: 2026-08-20
DESCrição: exercícios sobre GROUP By
Versão: 1.0
Histórico:
1.0 - Criação do script
*/

/*Escreva e execute uma instrução SELECT que retorne os 10 produtos de maior preço unitário (coluna ListPrice) na tabela 
“Production.Product”. */
SELECT TOP 10 * 
FROM Production.Product
ORDER BY ListPrice DESC, ProductID;


/*Escreva e execute um script que declara uma variável INT de nome @Top, inicializando esta variável com valor 5.  Utilize a 
instrução do item anterior (item 3) e no lugar do valor 10 no TOP utilize a variável.*/

DECLARE @Top INT;
SET @Top = 5;

SELECT TOP (@Top) * 
FROM Production.Product
ORDER BY ListPrice DESC, ProductID;

/*Utilize o comando TABLESAMPLE para retornar 30% das linhas da tabela “Production.Product”. Execute várias vezes a 
instrução e repare que a quantidade de linhas muda!*/

SELECT * 
FROM Production.Product
TABLESAMPLE (30 PERCENT);

/* Escreva e execute uma instrução SELECT que retorne o somatório das vendas (coluna TotalDue) por vendedor (coluna 
SalesPersonID) na tabela “Sales.SalesOrderHeader”.  Ordene o resultado pelo vendedor (coluna SalesPersonID) na 
ascendente. */

SELECT SalesPersonID, 
SUM(TotalDue) AS totalVendas
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
ORDER BY SalesPersonID;


/*O SELECT do item 1 retorna na primeira linha um vendedor NULL (coluna SalesPersonID), acrescente a este SELECT um filtro 
para eliminar do resultado a linha contendo NULL em SalesPersonID.*/

SELECT SalesPersonID, 
SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader 
WHERE SalesPersonID is not null
GROUP BY SalesPersonID
ORDER BY SalesPersonID;


/*Altere o SELECT do item 2 para que este retorne o total geral, isto é, somatório de todas as vendas de todos os vendedores, 
utilizando GROUPING SETS.  Ordene o resultado pelo Total de vendas na DESCendente.*/
SELECT SalesPersonID, sum(TotalDue) as Total
FROM Sales.SalesOrderHeader
WHERE SalesPersonID is not null
GROUP BY GROUPING SETS ((SalesPersonID),())
ORDER BY Total DESC

/*Escreva e execute uma instrução SELECT que retorne a quantidade de linhas para cada valor da coluna PersonType na tabela 
“Person.Person”.  Utilizando HAVING, retorne apenas os PersonType que tenham mais de 200 linhas.*/
SELECT PersonType,
Count([PersonType]) as QtdLinhas
FROM Person.Person
Group By PersonType
HAVING Count([PersonType]) > 200

/* A tabela “Sales.SalesPersonQuotaHistory” possui o histórico de vendas mensal por vendedor.  Elabore uma instrução 
SELECT que retorne o total de vendas por vendedor e por ano, utilizando as informações abaixo: 
• A coluna BusinessEntityID contém o identificador do vendedor, renomeie esta coluna para VendedorID no resultado. 
• A coluna QuotaDate contém a data que foi feito o somatório das vendas, você vai precisar utilizar uma função para extrair 
apenas o ano desta coluna, atribua o nome Ano no resultado. 
• A coluna SalesQuota contém o valor vendido, some os valores desta coluna e atribua o nome TotalVenda no resultado. 
• O resultado deverá estar ordenado pelo Ano e em seguida VendedorID. */

SELECT YEAR([QuotaDate]) as Ano,
BusinessEntityID as VendedorID,
SUM(SalesQuota)
FROM Sales.SalesPersonQuotaHistory
GROUP BY YEAR([QuotaDate]), BusinessEntityID
ORDER BY Ano, VendedorID

/* Altere o comando elaborado no item 5, acrescentando filtro para retornar apenas os totais de vendas de 2012 em diante.*/
SELECT YEAR([QuotaDate]) as Ano,
BusinessEntityID as VendedorID,
SUM(SalesQuota)
FROM Sales.SalesPersonQuotaHistory
GROUP BY YEAR([QuotaDate]), BusinessEntityID
HAVING YEAR([QuotaDate]) >= 2012
ORDER BY Ano, VendedorID

/*Altere o comando do item 6 acrescentando filtro para retornar apenas os totais de venda superiores a 3 milhões, ordenando 
o resultado pelo Ano e TotalVenda na DESCendente*/
SELECT BusinessEntityID as VendedorID,
YEAR([QuotaDate]) as Ano,
SUM(SalesQuota) as TotalVenda
FROM Sales.SalesPersonQuotaHistory
GROUP BY YEAR([QuotaDate]), BusinessEntityID
HAVING SUM(SalesQuota) > 3000000.00
ORDER BY Ano, TotalVenda DESC