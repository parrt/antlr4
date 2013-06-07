ALTER QUEUE ExpenseQueue
    WITH ACTIVATION (
        PROCEDURE_NAME = AdventureWorks.dbo.new_stored_proc ,
        EXECUTE AS 'SecurityAccount') ;
