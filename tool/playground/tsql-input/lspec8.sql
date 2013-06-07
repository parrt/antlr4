
SELECT * 
INTO #Bicycles
FROM Production.Product
WHERE ProductNumber LIKE 'BK%'


SELECT name 
FROM tempdb.sysobjects 
WHERE name LIKE '#Bicycles%' ;
GO

