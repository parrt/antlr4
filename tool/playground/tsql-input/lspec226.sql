CREATE TABLE cnst_example 
(id INT NOT NULL,
    name VARCHAR(10) NOT NULL,
    salary MONEY NOT NULL
    CONSTRAINT salary_cap CHECK (salary < 100000)
)

-- Valid inserts
INSERT INTO cnst_example VALUES (1,'Joe Brown',65000)
INSERT INTO cnst_example VALUES (2,'Mary Smith',75000)

-- This insert violates the constraint.
INSERT INTO cnst_example VALUES (3,'Pat Jones',105000)

-- Disable the constraint and try again.
ALTER TABLE cnst_example NOCHECK CONSTRAINT salary_cap
INSERT INTO cnst_example VALUES (3,'Pat Jones',105000)

-- Re-enable the constraint and try another insert; this will fail.
ALTER TABLE cnst_example CHECK CONSTRAINT salary_cap
INSERT INTO cnst_example VALUES (4,'Eric James',110000) ;

