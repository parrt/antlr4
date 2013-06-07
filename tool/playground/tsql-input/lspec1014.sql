USE AdventureWorks;
GO
UPDATE Sales.SalesPerson
SET SalesYTD = SalesYTD + 
    (SELECT SUM(so.SubTotal) 
	     FROM Sales.SalesOrderHeader AS so
	     WHERE so.OrderDate = (SELECT MAX(OrderDate)
		                           FROM Sales.SalesOrderHeader AS so2
					                           WHERE so2.SalesPersonID = 
								                                 so.SalesPersonID)
											     AND Sales.SalesPerson.SalesPersonID = so.SalesPersonID
											     GROUP BY so.SalesPersonID);
										GO
