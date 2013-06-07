EXEC sp_addlinkedserver 'OracleSvr', 
   'Oracle 7.3', 
   'MSDAORA', 
   'ORCLDB'
GO
SELECT *
FROM OPENQUERY(OracleSvr, 'SELECT name, id FROM joe.titles') 
GO

