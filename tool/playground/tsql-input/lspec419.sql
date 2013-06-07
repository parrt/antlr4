USE AdventureWorks;
GO
IF EXISTS (SELECT name FROM sys.indexes
            WHERE name = N'IX_TransactionHistory_ReferenceOrderID')
    DROP INDEX IX_TransactionHistory_ReferenceOrderID
        ON Production.TransactionHistory;
GO
CREATE NONCLUSTERED INDEX IX_TransactionHistory_ReferenceOrderID
ON Production.TransactionHistory (ReferenceOrderID)
ON TransactionsPS1 (TransactionDate);
GO
