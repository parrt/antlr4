USE AdventureWorks ;
GO
SELECT $PARTITION.TransactionRangePF1(TransactionDate) AS Partition, 
COUNT(*) AS [COUNT] FROM Production.TransactionHistory 
GROUP BY $PARTITION.TransactionRangePF1(TransactionDate)
ORDER BY Partition ;
GO
