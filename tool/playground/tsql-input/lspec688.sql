--Create the table and insert values as portrayed in the previous example.
CREATE TABLE pvt (VendorID int, Emp1 int, Emp2 int,
	Emp3 int, Emp4 int, Emp5 int)
GO
INSERT INTO pvt VALUES (1,4,3,5,4,4)
INSERT INTO pvt VALUES (2,4,1,5,5,5)
INSERT INTO pvt VALUES (3,4,3,5,4,4)
INSERT INTO pvt VALUES (4,4,2,5,5,4)
INSERT INTO pvt VALUES (5,5,1,5,5,5)
GO
--Unpivot the table.
SELECT VendorID, Employee, Orders
FROM 
    (SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5
	    FROM pvt) p
UNPIVOT
    (Orders FOR Employee IN 
	        (Emp1, Emp2, Emp3, Emp4, Emp5)
	)AS unpvt
	GO


