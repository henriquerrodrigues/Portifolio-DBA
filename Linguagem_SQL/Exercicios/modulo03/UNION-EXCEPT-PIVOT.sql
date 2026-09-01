/*
Autor: Henrique Rodrigues
Data: 2026-09-01
Descrição: Exercicio UNION EXCEPT PIVOT
Versão: 1.0
Histórico:
1.0 - resolução dos exercícios
*/

use AdventureWorks2012

/*Escreva e execute uma instrução SELECT que retorne o somatório (UNION ALL) das linhas das tabelas “Sales.vSalesPerson” e
“HumanResources.vEmployee”. Selecione as colunas FirstName, MiddleName, LastName e PhoneNumber, ordene o
resultado pelas colunas FirstName, MiddleName e LastName. 
*/

SELECT FirstName, MiddleName, LastName, PhoneNumber
FROM Sales.vSalesPerson
UNION ALL
SELECT  FirstName, MiddleName, LastName, PhoneNumber FROM HumanResources.vEmployee
ORDER BY FirstName, MiddleName, LastName

/* Altere a instrução SELECT anterior para eliminar do resultado linhas iguais. */
SELECT FirstName, MiddleName, LastName, PhoneNumber
FROM Sales.vSalesPerson
UNION
SELECT  FirstName, MiddleName, LastName, PhoneNumber FROM HumanResources.vEmployee
ORDER BY FirstName, MiddleName, LastName

/*. Escreva e execute uma instrução SELECT que retorne as linhas que existem na tabela “HumanResources.vEmployee” e que
não existem na tabela “Sales.vSalesPerson”. Selecione as colunas FirstName, MiddleName, LastName e PhoneNumber. 
*/
SELECT FirstName, MiddleName, LastName, PhoneNumber
FROM HumanResources.vEmployee
EXCEPT
SELECT  FirstName, MiddleName, LastName, PhoneNumber FROM Sales.vSalesPerson
ORDER BY FirstName, MiddleName, LastName

/*Escreva e execute uma instrução SELECT para retornar uma linha para cada ano na coluna OrderDate da tabela
“Sales.SalesOrderHeader”, ordene o resultado pelo Ano e guarde os valores.*/
SELECT DISTINCT YEAR(OrderDate) AS YearOrderDate
FROM Sales.SalesOrderHeader
ORDER BY YearOrderDate

/* Escreva e execute uma instrução SELECT com INNER JOIN entre as tabelas "Sales.SalesOrderHeader", "Sales.Customer" e
"Person.Person". Retorne a concatenação das colunas FirstName, MiddleName e LastName da tabela "Person.Person",
atribua o nome Customer. Retorne também a porção Ano da coluna OrderDate e a coluna TotalDue, ambas da tabela
"Sales.SalesOrderHeader". */
SELECT (ISNULL(FirstName, '') + ISNULL(' ' + MiddleName, '') + ISNULL(' '+ LastName, ''))  AS Customer,
YEAR(S.OrderDate) AS YearOrderDate,
S.TotalDue
FROM Sales.SalesOrderHeader S
JOIN Sales.Customer C ON c.CustomerID = s.CustomerID
JOIN Person.Person P ON P.BusinessEntityID = C.PersonID

/*Utilize a consulta do item 1.2 como uma Subconsulta, e faça uma operação de PIVOT, para consolidar os valores de
TotalDue por Ano. */

SELECT Customer, [2011], [2012], [2013], [2014]
FROM (
SELECT c.FirstName + isnull(' ' + c.MiddleName,'') + ' ' + c.LastName as Customer,
year(a.OrderDate) as YearOrderDate, a.TotalDue
FROM Sales.SalesOrderHeader a
JOIN Sales.Customer b  on b.CustomerID = a.CustomerID
JOIN Person.Person c on c.BusinessEntityID = b.PersonID) s
PIVOT (SUM(TotalDue) FOR YearOrderDate IN ([2011], [2012], [2013], [2014])) AS p
ORDER BY Customer

/* Um Ano como nome de coluna não está de acordo com as regras de nomes de objetos do SQL Server, você terá que
utilizar os [...], por exemplo [2011].
2. Crie uma tabela temporária de nome #PivotCustomer com o resultado da consulta do item 1.3, em seguida escreva uma
consulta utilizando a tabela temporária #PivotCustomer fazendo um UNPIVOT, convertendo os Anos de coluna para linha.*/

SELECT Customer, [2011], [2012], [2013], [2014]
INTO #PivotCustomer
FROM (
SELECT (ISNULL(FirstName, '') + ISNULL(' ' + MiddleName, '') + ISNULL(' '+ LastName, ''))  AS Customer,
YEAR(S.OrderDate) AS YearOrderDate,
S.TotalDue
FROM Sales.SalesOrderHeader S
JOIN Sales.Customer C ON c.CustomerID = s.CustomerID
JOIN Person.Person P ON P.BusinessEntityID = C.PersonID) R
PIVOT (SUM(totalDue) FOR YearOrderDate IN ([2011], [2012], [2013], [2014])) AS A
Order by Customer

--PIVOT
select * from #PivotCustomer

--UNPIVOT
SELECT u.Customer, u.Ano, u.TotalDue
FROM #PivotCustomer 
UNPIVOT(TotalDue FOR Ano IN ([2011], [2012], [2013], [2014])) as u
