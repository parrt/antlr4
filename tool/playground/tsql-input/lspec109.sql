SET NOCOUNT ON
IF @@OPTIONS & 512 > 0 
RAISERROR ('Current user has SET NOCOUNT turned on.', 1, 1)
