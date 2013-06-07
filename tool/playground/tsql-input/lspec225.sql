Use AdventureWorks ; 
GO
CREATE TABLE doc_exf ( column_a INT) ;
GO
INSERT INTO doc_exf
VALUES (1) ;
GO
ALTER TABLE doc_exf 
ADD AddDate smalldatetime NULL
CONSTRAINT AddDateDflt
DEFAULT GETDATE() WITH VALUES ;
GO
DROP TABLE doc_exf ;
GO

