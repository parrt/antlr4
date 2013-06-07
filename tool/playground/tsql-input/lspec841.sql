USE AdventureWorks;
SELECT PARSENAME('AdventureWorks..Contact', 1) AS 'Object Name';
SELECT PARSENAME('AdventureWorks..Contact', 2) AS 'Schema Name';
SELECT PARSENAME('AdventureWorks..Contact', 3) AS 'Database Name;'
SELECT PARSENAME('AdventureWorks..Contact', 4) AS 'Server Name';
GO

