USE pubs;
GO
ALTER DATABASE pubs SET RECOVERY SIMPLE;
GO
DECLARE @ptrval binary(16)
SELECT @ptrval = TEXTPTR(pr_info) 
FROM pub_info pr, publishers p
WHERE p.pub_id = pr.pub_id 
   AND p.pub_name = 'New Moon Books'
WRITETEXT pub_info.pr_info @ptrval 'New Moon Books (NMB) has just released another top ten publication. With the latest publication this makes NMB the hottest new publisher of the year!'
GO
ALTER DATABASE pubs SET RECOVERY SIMPLE;
GO
