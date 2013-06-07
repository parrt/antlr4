DECLARE @CursorVar CURSOR;

SET @CursorVar = CURSOR SCROLL DYNAMIC
FOR
SELECT LastName, FirstName
FROM AdventureWorks.HumanResources.vEmployee
WHERE LastName like 'B%';

OPEN @CursorVar;

FETCH NEXT FROM @CursorVar;
WHILE @@FETCH_STATUS = 0
	BEGIN
		    FETCH NEXT FROM @CursorVar
	END;

	CLOSE @CursorVar;
	DEALLOCATE @CursorVar;

