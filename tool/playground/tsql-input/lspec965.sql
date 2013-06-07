USE AdventureWorks ;
GO

CREATE PROCEDURE ManyDaysToComplete @OrderID int, @NumberOfDays int
AS
IF 
	@NumberOfDays < SOME
	   (
		    SELECT DaysToManufacture
		    FROM Sales.SalesOrderDetail
		    JOIN Production.Product 
		    ON Sales.SalesOrderDetail.ProductID = Production.Product.ProductID 
		    WHERE SalesOrderID = @OrderID
		   )
		PRINT 'At least one item for this order cannot be manufactured in specified number of days.'
	ELSE 
		PRINT 'All items for this order can be manufactured in the specified number of days or less.' ;

EXECUTE DaysToBuild 49080, 2 ;
EXECUTE DaysToBuild 49080, 1 ;

