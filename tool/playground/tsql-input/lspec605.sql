DROP AGGREGATE dbo.Concatenate
DROP APPLICATION ROLE weekly_ledger;
GO
DROP ASSEMBLY Helloworld 
USE AdventureWorks;
DROP ASYMMETRIC KEY MirandaXAsymKey6;
USE AdventureWorks;
DROP CERTIFICATE Shipping04;
DROP CONTRACT 
    [//Adventure-Works.com/Expenses/ExpenseSubmission] ;
DROP CREDENTIAL Saddles;
GO
DROP DATABASE Sales;
DROP DATABASE Sales, NewSales;
DROP DATABASE sales_snapshot0600;
USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sys.objects
	         WHERE name = 'datedflt' 
		            AND type = 'D')
			   DROP DEFAULT datedflt
GO

