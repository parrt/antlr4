CREATE SERVICE [//Adventure-Works.com/Expenses] ON QUEUE ExpenseQueue
    ([//Adventure-Works.com/Expenses/ExpenseSubmission],
     [//Adventure-Works.com/Expenses/ExpenseProcessing]) ;
