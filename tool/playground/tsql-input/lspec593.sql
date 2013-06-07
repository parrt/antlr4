USE AdventureWorks;
GO
DELETE FROM Sales.SalesPersonQuotaHistory;
GO

USE AdventureWorks;
GO
DELETE FROM Production.ProductCostHistory
	WHERE StandardCost > 1000.00;
GO

USE AdventureWorks;
GO
DECLARE complex_cursor CURSOR FOR
    SELECT a.EmployeeID
    FROM HumanResources.EmployeePayHistory AS a
    WHERE RateChangeDate <> 
         (SELECT MAX(RateChangeDate)
		          FROM HumanResources.EmployeePayHistory AS b
			          WHERE a.EmployeeID = b.EmployeeID) ;
OPEN complex_cursor;
FETCH FROM complex_cursor;
DELETE FROM HumanResources.EmployeePayHistory
	WHERE CURRENT OF complex_cursor;
CLOSE complex_cursor;
DEALLOCATE complex_cursor;
GO

-- SQL-2003 Standard subquery

USE AdventureWorks;
GO
DELETE FROM Sales.SalesPersonQuotaHistory 
WHERE SalesPersonID IN 
    (SELECT SalesPersonID 
	     FROM Sales.SalesPerson 
	     WHERE SalesYTD > 2500000.00);
GO

-- Transact-SQL extension
USE AdventureWorks;
GO
DELETE FROM Sales.SalesPersonQuotaHistory 
FROM Sales.SalesPersonQuotaHistory AS spqh
    INNER JOIN Sales.SalesPerson AS sp
    ON spqh.SalesPersonID = sp.SalesPersonID
WHERE sp.SalesYTD > 2500000.00;
GO

USE AdventureWorks;
GO
DELETE TOP (2.5) PERCENT 
FROM Production.ProductInventory;
GO

USE AdventureWorks;
GO
DELETE Sales.ShoppingCartItem
    OUTPUT DELETED.* ;

--Verify all rows in the table have been deleted.
SELECT COUNT(*) AS [Rows in Table] FROM Sales.ShoppingCartItem;
GO

USE AdventureWorks
GO
DECLARE @MyTableVar table (
	    ProductID int NOT NULL, 
	    ProductName nvarchar(50)NOT NULL,
	    ProductModelID int NOT NULL, 
	    PhotoID int NOT NULL);

DELETE Production.ProductProductPhoto
OUTPUT DELETED.ProductID,
       p.Name,
       p.ProductModelID,
       DELETED.ProductPhotoID
    INTO @MyTableVar
FROM Production.ProductProductPhoto AS ph
JOIN Production.Product as p 
    ON ph.ProductID = p.ProductID 
    WHERE p.ProductModelID BETWEEN 120 and 130;

--Display the results of the table variable.
SELECT ProductID, ProductName, ProductModelID, PhotoID 
FROM @MyTableVar
ORDER BY ProductModelID;
GO


