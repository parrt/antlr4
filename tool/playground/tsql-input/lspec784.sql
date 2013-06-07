DECLARE @conversation_handle UNIQUEIDENTIFIER,
        @conversation_group_id UNIQUEIDENTIFIER ;

	SET @conversation_handle =
	    'jim';
	SET @conversation_group_id =
	    'jim';

	MOVE CONVERSATION @conversation_handle TO @conversation_group_id ;

