USE pubs
GO
DECLARE @ptrval varbinary(16)
SELECT @ptrval = TEXTPTR(logo) 
FROM pub_info pr, publishers p
WHERE p.pub_id = pr.pub_id 
   AND p.pub_name = 'New Moon Books'
GO
