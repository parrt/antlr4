USE AdventureWorks
GO
-- Declare and open a global cursor.
DECLARE abc CURSOR KEYSET FOR
SELECT LastName
FROM Person.Contact
WHERE LastName LIKE 'S%'

OPEN abc
GO
-- Declare a cursor variable to hold the cursor output variable
-- from sp_describe_cursor_tables.
DECLARE @Report CURSOR

-- Execute sp_describe_cursor_tables into the cursor variable.
EXEC master.dbo.sp_describe_cursor_tables
      @cursor_return = @Report OUTPUT,
      @cursor_source = N'global', @cursor_identity = N'abc'

-- Fetch all the rows from the sp_describe_cursor_tables output cursor.
FETCH NEXT from @Report
WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		   FETCH NEXT from @Report
	END

	-- Close and deallocate the cursor from sp_describe_cursor_tables.
CLOSE @Report
DEALLOCATE @Report
GO

-- Close and deallocate the original cursor.
CLOSE abc
DEALLOCATE abc
GO

