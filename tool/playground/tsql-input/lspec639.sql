USE AdventureWorks;
GO
SELECT ProductID 
FROM Production.Product ;
USE AdventureWorks;
GO
SELECT ProductID 
FROM Production.Product
INTERSECT
SELECT ProductID 
FROM Production.WorkOrder ;
USE AdventureWorks;
GO
SELECT ProductID 
FROM Production.Product
EXCEPT
SELECT ProductID 
FROM Production.WorkOrder ;
USE AdventureWorks;
GO
SELECT ProductID 
FROM Production.WorkOrder
EXCEPT
SELECT ProductID 
FROM Production.Product ;

