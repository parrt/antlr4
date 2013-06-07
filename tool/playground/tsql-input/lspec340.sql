USE AdventureWorks;
GO
SELECT COLUMNPROPERTY( OBJECT_ID('Person.Contact'),'LastName','PRECISION')AS 'Column Length';
GO
