DECLARE @MyNumber int
SET @MyNumber = 4 - 2 + 27
-- Evaluates to 2 + 27 which yields an expression result of 29.
SELECT @MyNumber
DECLARE @MyNumber int
SET @MyNumber = 2 * 4 + 5
-- Evaluates to 8 + 5 which yields an expression result of 13.
SELECT @MyNumber
DECLARE @MyNumber int
SET @MyNumber = 2 * (4 + 5)
-- Evaluates to 2 * 9 which yields an expression result of 18.
SELECT @MyNumber
DECLARE @MyNumber int
SET @MyNumber = 2 * (4 + (5 - 3) )
-- Evaluates to 2 * (4 + 2) which then evaluates to 2 * 6, and 
-- yields an expression result of 12.
SELECT @MyNumber

