/*
Autor: Henrique Rodrigues
Data: 2026-08-14
Descrição: Script referente ao exercício do Modulo 02: consultas com iniciais com T-SQL
Versão: 1.0
Histórico:
1.0 - Criação do script
*/

USE AdventureWorks2012
GO

SET STATISTICS IO ON

--Exercício 01

/*Escreva e execute uma instrução SELECT que recupere todas as colunas e todas as linhas da tabela “Person.Person”.  Seu 
resultado ficará similar ao da imagem abaixo. */

SELECT * FROM Person.Person


/*Escreva e execute uma instrução SELECT que recupere as colunas BusinessEntityID, Title, FirstName, MiddleName e 
LastName da tabela “Person.Person”. Seu resultado ficará similar ao da imagem abaixo.*/

SELECT p.BusinessEntityID, p.Title, p.FirstName, p.MiddleName, p.LastName
FROM Person.Person p

/*Escreva e execute uma instrução SELECT que recupere as colunas BusinessEntityID, Title, FirstName, MiddleName e 
LastName da tabela “Person.Person”. Selecione apenas as linhas onde na coluna Title tenha apenas “Mr.”.*/

SELECT p.BusinessEntityID, p.Title, p.FirstName, p.MiddleName, p.LastName
FROM Person.Person p
WHERE p.Title  like 'Mr.%' 

/*Escreva e execute uma instrução SELECT que recupere as colunas ProductID, Name, ProductNumber, Color, 
SafetyStockLevel e ListPrice da tabela “Production.Product”, mas apenas as linhas que tenham a palavra “Ball” em qualquer 
posição da coluna Name.*/

SELECT ProductID, Name, ProductNumber, Color, SafetyStockLevel, ListPrice
FROM Production.Product
WHERE Name like '%Ball%'

/*Escreva e execute uma instrução SELECT que recupere as colunas ProductID, Name, ProductNumber, Color, 
SafetyStockLevel, ListPrice e MakeFlag da tabela “Production.Product”, mas apenas as linhas que tenham a palavra “Ball” em 
qualquer posição na coluna Name e valor zero na coluna MakeFlag.*/

SELECT ProductID, Name, ProductNumber, Color, SafetyStockLevel, ListPrice, MakeFlag
FROM Production.Product
WHERE MakeFlag = 0
AND Name like '%Ball%'

/*Escreva e execute uma instrução SELECT que recupere as colunas SalesOrderID, OrderDate, SalesOrderNumber, 
CustomerID, SalesPersonID e TotalDue da tabela “Sales.SalesOrderHeader”, mas apenas as linhas onde na coluna TotalDue 
tenha valores entre 1000 e 1500. */

SELECT SalesOrderID, OrderDate, SalesOrderNumber, CustomerID, SalesPersonID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue BETWEEN 1000 AND 1500


/* Escreva e execute uma instrução SELECT que recupere as colunas Title, FirstName, MiddleName, LastName e Suffix da 
tabela “Person.Person”, mas apenas as linhas onde na coluna Suffix exista algum valor (isto é, sem NULL).  Transforme o NULL 
da coluna Title para “n/a”.*/

SELECT isnull(Title, 'n/a') as Title, FirstName, MiddleName, LastName, Suffix
FROM Person.Person
WHERE Suffix is not null

--Exercicio 02

/*Escreva e execute uma instrução SELECT que recupere as colunas FirstName, LastName, EmailPromotion da tabela 
“Person.Person”, ordenado pelo LastName (ascendente) e EmailPromotion (descendente).*/

SELECT FirstName, LastName, EmailPromotion 
FROM Person.Person
ORDER BY Lastname, EmailPromotion DESC


/*Escreva e execute uma instrução SELECT na tabela “Person.Person”, que recupere as colunas BusinessEntityID, FirstName, 
MiddleName, LastName e como última coluna o resultado da concatenação das três colunas para formar o nome completo 
(FirstName, MiddleName e LastName)*/

SELECT BusinessEntityID, FirstName, MiddleName, LastName, (FirstName + ISNULL((' '+ MiddleName), '') + ' ' + LastName) AS FullName
FROM Person.Person

/*Escreva e execute uma instrução SELECT que recupere da tabela “Sales.SalesOrderHeader” as colunas SalesOrderID, 
OrderDate, SalesOrderNumber, CustomerID e TotalDue.  Como última coluna remova a String “SO” do início da coluna 
SalesOrderNumber, convertendo o resultado para o Tipo de Dados INT, atribuindo o nome “SalesOrderNumber_int” para 
coluna resultante da expressão.  Filtre as linhas do resultado de modo que só retorne os pedidos com a data “20130704” em 
OrderDate. */

SELECT SalesOrderID, REPLACE(CONVERT(date, OrderDate, 112), '-', '') AS OrderDate, SalesOrderNumber, CustomerID, TotalDue, 
CAST(REPLACE(SalesOrderNumber, 'SO', '') AS INT) AS SalesOrderNumber_int
FROM Sales.SalesOrderHeader
WHERE OrderDate = '20130704'