USE pubs;
GO
ALTER DATABASE pubs SET RECOVERY SIMPLE;
GO
DECLARE @ptrval binary(16)
SELECT @ptrval = TEXTPTR(pr_info) 
   FROM pub_info pr, publishers p
      WHERE p.pub_id = pr.pub_id 
      AND p.pub_name = 'New Moon Books'
UPDATETEXT pub_info.pr_info @ptrval 88 1 'b';
GO
ALTER DATABASE pubs SET RECOVERY FULL;
GO
