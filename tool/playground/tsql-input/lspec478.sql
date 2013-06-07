CREATE RULE range_rule
AS 
@range>= $1000 AND @range <$20000;
