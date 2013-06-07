END CONVERSATION @dialog_handle ;
DECLARE @dialog_handle UNIQUEIDENTIFIER,
        @ErrorSave INT,
	@ErrorDesc NVARCHAR(100) ;
BEGIN TRANSACTION ;

--	<receive and process message>

SET @ErrorSave = @@ERROR ;

IF (@ErrorSave <> 0)
  BEGIN
      ROLLBACK TRANSACTION ;
      SET @ErrorDesc = N'An error has occurred.' ;
     END CONVERSATION @dialog_handle 
         WITH ERROR = @ErrorSave DESCRIPTION = @ErrorDesc ;
  END
ELSE
	COMMIT TRANSACTION ;


END CONVERSATION @dialog_handle WITH CLEANUP ;

