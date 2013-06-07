USE pubs
GO
SELECT pub_id, TEXTPTR(pr_info)
FROM pub_info
ORDER BY pub_id
GO

