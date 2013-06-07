SELECT FirstName, Lastname, TelephoneNumber, 
     IIf(IsNull(TelephoneInstructions),"Any time",
     TelephoneInstructions) AS [When to Contact]
FROM db1.ContactInfo 


USE AdventureWorks
GO
SELECT FirstName, Lastname, TelephoneNumber, 'When to Contact' = 
     CASE
          WHEN TelephoneSpecialInstructions IS NULL THEN 'Any time'
          ELSE TelephoneSpecialInstructions
     END
FROM Person.vAdditionalContactInfo

