-- Genealogy table
IF OBJECT_ID('Person','U') IS NOT NULL DROP TABLE Person;
	GO
	CREATE TABLE Person(ID int, Name varchar(30), Mother int, Father int);
	GO
	INSERT Person VALUES(1, 'Sue', NULL, NULL);
	INSERT Person VALUES(2, 'Ed', NULL, NULL);
	INSERT Person VALUES(3, 'Emma', 1, 2);
	INSERT Person VALUES(4, 'Jack', 1, 2);
	INSERT Person VALUES(5, 'Jane', NULL, NULL);
	INSERT Person VALUES(6, 'Bonnie', 5, 4);
	INSERT Person VALUES(7, 'Bill', 5, 4);
	GO
	-- Create the recursive CTE to find all of Bonnie's ancestors.
WITH Generation (ID) AS
(
	-- First anchor member returns Bonnie's mother.
    SELECT Mother 
    FROM Person
    WHERE Name = 'Bonnie'
UNION
-- Second anchor member returns Bonnie's father.
    SELECT Father 
    FROM Person
    WHERE Name = 'Bonnie'
UNION ALL
-- First recursive member returns male ancestors of the previous generation.
    SELECT Person.Father
    FROM Generation, Person
    WHERE Generation.ID=Person.ID
UNION ALL
-- Second recursive member returns female ancestors of the previous generation.
    SELECT Person.Mother
    FROM Generation, Person
    WHERE Generation.ID=Person.ID
)
SELECT Person.ID, Person.Name, Person.Mother, Person.Father
FROM Generation, Person
WHERE Generation.ID = Person.ID;
GO
