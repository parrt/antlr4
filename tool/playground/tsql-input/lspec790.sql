CREATE TABLE myTable (ColumnA uniqueidentifier DEFAULT NEWSEQUENTIALID()) 
CREATE TABLE myTable (ColumnA uniqueidentifier DEFAULT dbo.myfunction(NEWSEQUENTIALID())) 

