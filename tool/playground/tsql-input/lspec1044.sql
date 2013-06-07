USE AdventureWorks;
GO
WHILE (SELECT AVG(ListPrice) FROM Production.Product) < $300
	BEGIN
		   UPDATE Production.Product
		      SET ListPrice = ListPrice * 2
		   SELECT MAX(ListPrice) FROM Production.Product
		   IF (SELECT MAX(ListPrice) FROM Production.Product) > $500
			      BREAK
			   ELSE
				      CONTINUE
			END
			PRINT 'Too much for the market to bear';
