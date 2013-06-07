USE MASTER;
CREATE CERTIFICATE certificateName
    WITH SUBJECT = '<login_name> certificate in master database',
    EXPIRY_DATE = '02/02/2009';
GO
CREATE LOGIN login_name FROM CERTIFICATE certificateName;
GO
