CREATE TABLE Orders
   (OrderID     int        PRIMARY KEY,
	    CustomerID  nchar(5)   REFERENCES Customers(CustomerID),
	    Workstation nchar(30)  NOT NULL DEFAULT HOST_NAME(),
	    OrderDate   datetime   NOT NULL,
	    ShipDate    datetime   NULL,
	    ShipperID   int        NULL REFERENCES Shippers(ShipperID));
GO

