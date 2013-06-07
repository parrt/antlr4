USE AdventureWorks
GO
SELECT VendorID, [164] AS Emp1, [198] AS Emp2, [223] AS Emp3, [231] AS Emp4, [233] AS Emp5
FROM 
(SELECT PurchaseOrderID, EmployeeID, VendorID
	FROM Purchasing.PurchaseOrderHeader) p
PIVOT
(
	COUNT (PurchaseOrderID)
	FOR EmployeeID IN
	( [164], [198], [223], [231], [233] )
) AS pvt
ORDER BY VendorID;


