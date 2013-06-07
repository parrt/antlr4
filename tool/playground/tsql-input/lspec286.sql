DECLARE @dialog_handle UNIQUEIDENTIFIER
DECLARE @existing_conversation_handle UNIQUEIDENTIFIER

SET @existing_conversation_handle = 'id';

BEGIN DIALOG CONVERSATION @dialog_handle
   FROM SERVICE [//Adventure-Works.com/ExpenseClient]
   TO SERVICE '//Adventure-Works.com/Expenses'
   ON CONTRACT [//Adventure-Works.com/Expenses/ExpenseSubmission]
   WITH RELATED_CONVERSATION = @existing_conversation_handle
   LIFETIME = 600 ;
