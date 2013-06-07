--Create the tables and insert the values.
CREATE TABLE SUPPLY1 (
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 1 and 150),
supplier CHAR(50)
);
CREATE TABLE SUPPLY2 (
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 151 and 300),
supplier CHAR(50)
);
CREATE TABLE SUPPLY3 (
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 301 and 450),
supplier CHAR(50)
);
CREATE TABLE SUPPLY4 (
supplyID INT PRIMARY KEY CHECK (supplyID BETWEEN 451 and 600),
supplier CHAR(50)
);
GO
INSERT SUPPLY1 VALUES ('1', 'CaliforniaCorp');
INSERT SUPPLY1 VALUES ('5', 'BraziliaLtd');
INSERT SUPPLY2 VALUES ('231', 'FarEast');
INSERT SUPPLY2 VALUES ('280', 'NZ');
INSERT SUPPLY3 VALUES ('321', 'EuroGroup');
INSERT SUPPLY3 VALUES ('442', 'UKArchip');
INSERT SUPPLY4 VALUES ('475', 'India');
INSERT SUPPLY4 VALUES ('521', 'Afrique');
GO
--Create the view that combines all supplier tables.
CREATE VIEW all_supplier_view
AS
SELECT *
FROM SUPPLY1
UNION ALL
SELECT *
FROM SUPPLY2
UNION ALL
SELECT *
FROM SUPPLY3
UNION ALL
SELECT *
FROM SUPPLY4;

