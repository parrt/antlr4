CREATE SERVICE [//Adventure-Works.com/Expenses]
    ON QUEUE [dbo].[ExpenseQueue]
    ([//Adventure-Works.com/Expenses/ExpenseSubmission]) ;
