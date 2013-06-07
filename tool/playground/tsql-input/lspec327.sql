/*Use the index in a SELECT query. Add a second search 
condition to catch stray cases where checksums match, 
but the values are not the same.*/
SELECT * 
FROM Production.Product
WHERE CHECKSUM(N'Bearing Ball') = cs_Pname
AND Name = N'Bearing Ball';
GO
