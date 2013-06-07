USE AdventureWorks ;
GO

CREATE PROCEDURE DaysToBuild @OrderID int, @NumberOfDays int
AS
IF 
@NumberOfDays >= ALL
   (
    SELECT DaysToManufacture
    FROM Sales.SalesOrderDetail
    JOIN Production.Product 
    ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID 
    WHERE SalesOrderID = @OrderID
   )
PRINT 'All items for this order can be manufactured in specified number of days or less.'
ELSE 
PRINT 'Some items for this order cannot be manufactured in specified number of days or less.' ;

EXECUTE DaysToBuild 49080, 2 ;
EXECUTE DaysToBuild 49080, 1 ;

