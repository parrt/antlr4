USE AdventureWorks;
GO
IF OBJECT_ID (N'uContact2', N'TR') IS NOT NULL
    DROP TRIGGER Person.tr1;
GO
CREATE TRIGGER uContact2 ON Person.Contact
AFTER UPDATE AS
    IF ( (SUBSTRING(COLUMNS_UPDATED(),1,1) & 20 = 20) 
        AND (SUBSTRING(COLUMNS_UPDATED(),2,1) & 1 = 1) ) 
    PRINT 'Columns 3, 5 and 9 updated';
GO

UPDATE Person.Contact 
   SET Title=Title,
      MiddleName=MiddleName,
      EmailPromotion=EmailPromotion;
GO
