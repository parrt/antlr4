USE AdventureWorks
GO
-- Declare and open a keyset-driven cursor.
DECLARE abc CURSOR KEYSET FOR
SELECT LastName
FROM Person.Contact
WHERE LastName LIKE 'S%'
OPEN abc

-- Declare a cursor variable to hold the cursor output variable
-- from sp_cursor_list.
DECLARE @Report CURSOR

-- Execute sp_cursor_list into the cursor variable.
EXEC master.dbo.sp_cursor_list @cursor_return = @Report OUTPUT,
      @cursor_scope = 2

-- Fetch all the rows from the sp_cursor_list output cursor.
FETCH NEXT from @Report
WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		   FETCH NEXT from @Report
	END

	-- Close and deallocate the cursor from sp_cursor_list.
CLOSE @Report
DEALLOCATE @Report
GO

-- Close and deallocate the original cursor.
CLOSE abc
DEALLOCATE abc
GO

