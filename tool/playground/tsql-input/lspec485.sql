USE AdventureWorks;
GO
CREATE STATISTICS ContactMail1
    ON Person.Contact (ContactID, EmailAddress)
    WITH SAMPLE 5 PERCENT;

