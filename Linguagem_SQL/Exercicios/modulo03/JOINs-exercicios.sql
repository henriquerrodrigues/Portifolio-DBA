/*
Autor: Henrique Rodrigues
Data: 2026-08-21
Descrição: parte dois dos exercícios do módulo 03 -  JOINs
Versão: 1.0
Histórico:
1.0 - Criação do script
*/

/*Escreva e execute uma instrução SELECT com INNER JOIN entre as tabelas “Production.Product” e 
“Production.ProductSubcategory”, utilizando como chave a coluna ProductSubcategoryID de ambas as tabelas.   
Retorne as colunas Name (renomear para Product), ProductNumber, Color e ListPrice, da tabela “Production.Product”.  
Retorne também a coluna Name (renomear para SubCategory) da tabela “Production.ProductSubcategory”.  Retorne apenas 
as linhas com categorias (coluna Name de ProductSubcategory) iniciando com “C”, ordene o resultado por Subcategory e 
depois por Product */

SELECT s.Name as SubCategory,
p.Name as Product,
p.ProductNumber, 
p.Color, 
p.ListPrice
FROM Production.Product p
JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID = p.ProductSubcategoryID
WHERE  s.Name like 'C%'
ORDER BY SubCategory, Product


/*Altere a instrução SELECT do item 1, acrescentando a tabela “Production.ProductCategory” ao JOIN, relacionando esta 
tabela com a tabela “Production.ProductSubcategory”, partir da coluna ProductCategoryID que existe em ambas as tabelas. 
Inclua como primeira coluna do SELECT a coluna Name (renomear para Category) da tabela ProductCategory, acrescentando 
esta coluna também como primeira do ORDER BY.  Altere o filtro WHERE para retornar apenas as linhas da categoria “Bikes” 
(coluna Name da tabela ProductCategory). */

SELECT c.Name as Category,
s.Name as SubCategory,
p.Name as Product,
p.ProductNumber, 
p.Color, 
p.ListPrice
FROM Production.Product p
JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID = p.ProductSubcategoryID
JOIN Production.ProductCategory c on c.ProductCategoryID = s.ProductCategoryID
WHERE  s.Name like '%Bikes%'
ORDER BY Category, SubCategory, Product


/*Utilizando o diagrama, elabore as instruções a seguir. 
5.1) Retorne o total de compras agrupando por cliente (tabela Customer), onde: 
 Relacione a tabela “Sales.Customer” com “Person.Person” e utilize as colunas FirstName, MiddleName, LastName para 
identificar o cliente, agrupando a partir destas três colunas. 
 Relacione a tabela “Sales.Customer” com “Sales.SalesOrderHeader” e utilize a coluna TotalDue para somar o total de 
compras por cliente. 
 O resultado deve estar ordenado pelo total da venda (TotalDue) na ordem descendente.*/

SELECT p.FirstName,
p.MiddleName, 
p.LastName,
sum(s.TotalDue) TotalDue
FROM Sales.Customer c 
JOIN Sales.SalesOrderHeader s ON c.CustomerID =  s.CustomerID
JOIN Person.Person p ON p.BusinessEntityID = c.PersonID
GROUP BY p.FirstName, p.MiddleName, p.LastName
ORDER BY TotalDue desc

/*b) Altere a instrução anterior acrescentando um filtro para retornar apenas os clientes com vendas iguais ou superiores a 
50000, e concatene as colunas FirstName, MiddleName e LastName formando uma coluna chamada Cliente.*/

SELECT p.FirstName + isnull(' ' + p.MiddleName, '') + isnull(' ' + p.LastName, '') as Cliente,
sum(s.TotalDue) TotalDue
FROM Sales.Customer c 
JOIN Sales.SalesOrderHeader s ON c.CustomerID =  s.CustomerID
JOIN Person.Person p ON p.BusinessEntityID = c.PersonID
GROUP BY p.FirstName + isnull(' ' + p.MiddleName, '') + isnull(' ' + p.LastName, '')
HAVING sum(s.TotalDue) >= 50000
ORDER BY TotalDue desc