USE AdventureWorks;
GO
SELECT 
    INDEXKEY_PROPERTY(OBJECT_ID('Production.Location', 'U'),
	        1,1,'ColumnId') AS [Column ID],
	    INDEXKEY_PROPERTY(OBJECT_ID('Production.Location', 'U'),
		        1,1,'IsDescending') AS [Asc or Desc order];


