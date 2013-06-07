DECLARE @conversation_group_id UNIQUEIDENTIFIER ;

WAITFOR (
	 GET CONVERSATION GROUP @conversation_group_id
	     FROM ExpenseQueue
) ;

DECLARE @conversation_group_id UNIQUEIDENTIFIER

WAITFOR (
	    GET CONVERSATION GROUP @conversation_group_id 
	    FROM ExpenseQueue ),
TIMEOUT 60000 ;

DECLARE @conversation_group_id UNIQUEIDENTIFIER ;

GET CONVERSATION GROUP @conversation_group_id
FROM AdventureWorks.dbo.ExpenseQueue ;

