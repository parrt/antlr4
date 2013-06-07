SELECT * FROM Production.TransactionHistory
WHERE $PARTITION.TransactionRangePF1(TransactionDate) = 5 ;
