USE AdventureWorks;
GO
SELECT LastName, SUBSTRING(FirstName, 1, 1) AS Initial
FROM Person.Contact
WHERE LastName like 'Barl%'
ORDER BY LastName
SELECT x = SUBSTRING('abcdef', 2, 3)
USE pubs
SELECT pub_id, SUBSTRING(logo, 1, 10) AS logo, 
   SUBSTRING(pr_info, 1, 10) AS pr_info
FROM pub_info
WHERE pub_id = '1756'

