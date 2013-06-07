REVOKE EXECUTE ON sys.sp_addlinkedserver FROM public;
GO
REVOKE VIEW DEFINITION ON TYPE::Telemarketing.PhoneNumber 
    FROM KhalidR CASCADE;
GO
USE AdventureWorks; 

REVOKE EXECUTE ON XML SCHEMA COLLECTION::Sales.Invoices4 FROM Wanida; 

GO 

