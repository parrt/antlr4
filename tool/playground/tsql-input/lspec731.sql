CREATE TABLE Orders
   (OrderID     int       PRIMARY KEY,
	    CustomerID  nchar(5)  REFERENCES Customers(CustomerID),
	    TerminalID  char(8)   NOT NULL DEFAULT HOST_ID(),
	    OrderDate   datetime  NOT NULL,
	    ShipDate    datetime  NULL,
	    ShipperID   int       NULL REFERENCES Shippers(ShipperID));
GO

