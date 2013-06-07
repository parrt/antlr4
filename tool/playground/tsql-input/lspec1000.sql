USE pubs
GO
DECLARE @val varbinary(16)
SELECT @val = TEXTPTR(pr_info) 
FROM pub_info
WHERE pub_id = '0736'
READTEXT pub_info.pr_info @val 4 10
GO

