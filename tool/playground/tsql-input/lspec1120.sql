DECLARE @x1 int = 27;
SET @x1 += 2 ;
SELECT @x1 AS Added_2;

DECLARE @x2 int = 27;
SET @x2 -= 2 ;
SELECT @x2 AS Subtracted_2;

DECLARE @x3 int = 27;
SET @x3 *= 2 ;
SELECT @x3 AS Multiplied_by_2;

DECLARE @x4 int = 27;
SET @x4 /= 2 ;
SELECT @x4 AS Divided_by_2;

DECLARE @x5 int = 27;
SET @x5 %= 2 ;
SELECT @x5 AS Modulo_of_27_divided_by_2;

DECLARE @x6 int = 9;
SET @x6 &= 13 ;
SELECT @x6 AS Bitwise_AND;

DECLARE @x7 int = 27;
SET @x7 ^= 2 ;
SELECT @x7 AS Bitwise_Exclusive_OR;

DECLARE @x8 int = 27;
SET @x8 |= 2 ;
SELECT @x8 AS Bitwise_OR;

