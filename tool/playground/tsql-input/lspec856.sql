USE pubs;
GO
DECLARE @ptrval varbinary(16);
SELECT @ptrval = TEXTPTR(pr_info) 
   FROM pub_info pr INNER JOIN publishers p
      ON pr.pub_id = p.pub_id 
      AND p.pub_name = 'New Moon Books'
READTEXT pub_info.pr_info @ptrval 1 25;
GO

