USE AdventureWorks;
GO
SELECT @@CURSOR_ROWS;
DECLARE Name_Cursor CURSOR FOR
SELECT LastName ,@@CURSOR_ROWS FROM Person.Contact;
OPEN Name_Cursor;
FETCH NEXT FROM Name_Cursor;
SELECT @@CURSOR_ROWS;
CLOSE Name_Cursor;
DEALLOCATE Name_Cursor;
GO  
