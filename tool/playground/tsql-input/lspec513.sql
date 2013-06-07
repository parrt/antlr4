USE AdventureWorks;
CREATE CERTIFICATE CarnationProduction50
    WITH SUBJECT = 'Carnation Production Facility Supervisors',
    EXPIRY_DATE = '11/11/2011';
GO
CREATE USER JinghaoLiu FOR CERTIFICATE CarnationProduction50;
GO
