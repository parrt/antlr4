
CREATE STATISTICS NamePurchase
    ON AdventureWorks.Person.Contact (ContactID, EmailAddress)
    WITH FULLSCAN, NORECOMPUTE;

