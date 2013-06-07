USE AdventureWorks;
SELECT Name, Description FROM fn_helpcollations()
WHERE name like 'L%' AND description LIKE '% binary sort';

