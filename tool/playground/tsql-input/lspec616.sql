DROP MESSAGE TYPE [//Adventure-Works.com/Expenses/SubmitExpense] ;
DROP PARTITION FUNCTION myRangePF;
DROP PARTITION SCHEME myRangePS1;
DROP PROCEDURE dbo.uspMyProc;
GO
DROP QUEUE ExpenseQueue ;

DROP REMOTE SERVICE BINDING APBinding ;
USE AdventureWorks;
DROP ROLE purchasing;
GO
DROP ROUTE ExpenseRoute ;
USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sysobjects
	         WHERE name = 'VendorID_rule'
		            AND type = 'R')
BEGIN
      EXEC sp_unbindrule 'Production.ProductVendor.VendorID'
      DROP RULE VendorID_rule
END

