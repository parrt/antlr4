USE AdventureWorks;
GO
DECLARE @MyTableVar table( ScrapReasonID smallint,
	                           Name varchar(50),
				                           ModifiedDate datetime);
						INSERT Production.ScrapReason
						    OUTPUT INSERTED.ScrapReasonID, INSERTED.Name, INSERTED.ModifiedDate
						        INTO @MyTableVar
							VALUES (N'Operator error', GETDATE());

							--Display the result set of the table variable.
SELECT ScrapReasonID, Name, ModifiedDate FROM @MyTableVar;
--Display the result set of the table.
SELECT ScrapReasonID, Name, ModifiedDate 
FROM Production.ScrapReason;
GO


