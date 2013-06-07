USE AdventureWorks;
CREATE APPLICATION ROLE weekly_receipts 
    WITH PASSWORD = '987Gbv8$76sPYY5m23' , 
    DEFAULT_SCHEMA = Sales;
GO
ALTER APPLICATION ROLE weekly_receipts 
    WITH NAME = receipts_ledger;
GO
