DECLARE @dialog_handle UNIQUEIDENTIFIER ;
DECLARE @conversation_group_id UNIQUEIDENTIFIER ;

SET @conversation_group_id = 'id';

BEGIN DIALOG CONVERSATION @dialog_handle
   FROM SERVICE [//Adventure-Works.com/ExpenseClient]
   TO SERVICE '//Adventure-Works.com/Expenses'
   ON CONTRACT [//Adventure-Works.com/Expenses/ExpenseSubmission]
   WITH RELATED_CONVERSATION_GROUP = @conversation_group_id ;
