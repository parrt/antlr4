IF EXISTS (SELECT table_name FROM INFORMATION_SCHEMA.TABLES 
	      WHERE table_name = 'npub_info')
	   DROP TABLE npub_info
	GO
	-- Create npub_info table in pubs database. Borrowed from instpubs.sql.
USE pubs
GO
CREATE TABLE npub_info
(
	 pub_id         char(4)           NOT NULL
	         REFERENCES publishers(pub_id)
		         CONSTRAINT UPKCL_npubinfo PRIMARY KEY CLUSTERED,
			 pr_info        ntext             NULL
		)

		GO

		-- Fill the pr_info column in npub_info with international data.
RAISERROR('Now at the inserts to pub_info...',0,1)

GO

INSERT npub_info VALUES('0736', N'This is sample text data for New Moon Books, publisher 0736 in the pubs database')
INSERT npub_info values('0877', N'This is sample text data for Binnet & Hardley, publisher 0877 in the pubs databa')
INSERT npub_info values('1389', N'This is sample text data for Algodata Infosystems, publisher 1389 in the pubs da')
INSERT npub_info values('9952', N'This is sample text data for Scootney Books, publisher 9952 in the pubs database')
INSERT npub_info values('1622', N'This is sample text data for Five Lakes Publishing, publisher 1622 in the pubs d')
INSERT npub_info values('1756', N'This is sample text data for Ramona Publishers, publisher 1756 in the pubs datab')
INSERT npub_info values('9901', N'This is sample text data for GGG&G, publisher 9901 in the pubs database. GGG&G i')
INSERT npub_info values('9999', N'This is sample text data for Lucerne Publishing, publisher 9999 in the pubs data')
GO
-- Join between npub_info and pub_info on pub_id.
SELECT pr.pub_id, SUBSTRING(pr.pr_info, 1, 35) AS pr_info,
   SUBSTRING(npr.pr_info, 1, 35) AS npr_info
FROM pub_info pr INNER JOIN npub_info npr
   ON pr.pub_id = npr.pub_id
ORDER BY pr.pub_id ASC

