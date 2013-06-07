SET QUOTED_IDENTIFIER OFF
GO
-- An attempt to create a table with a reserved keyword as a name
-- should fail.
CREATE TABLE "select" ("identity" INT IDENTITY NOT NULL, "order" INT NOT NULL)
GO

SET QUOTED_IDENTIFIER ON
GO

-- Will succeed.
CREATE TABLE "select" ("identity" INT IDENTITY NOT NULL, "order" INT NOT NULL)
GO

SELECT "identity","order" 
FROM "select"
ORDER BY "order"
GO

DROP TABLE "SELECT"
GO

SET QUOTED_IDENTIFIER OFF
GO

