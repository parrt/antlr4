CREATE QUEUE ExpenseQueue
    WITH STATUS = OFF,
      RETENTION = ON,
      ACTIVATION (
          PROCEDURE_NAME = AdventureWorks.dbo.expense_procedure,
          MAX_QUEUE_READERS = 10,
          EXECUTE AS SELF )
    ON [DEFAULT] ;
