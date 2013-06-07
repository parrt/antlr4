USE AdventureWorks;
GO
-- Set ONLINE = OFF to execute this example on editions other than Enterprise Edition.
ALTER TABLE Production.ProductCostHistory
    DROP CONSTRAINT PK_ProductCostHistory_ProductID_StartDate
        WITH (ONLINE = ON);
	GO


