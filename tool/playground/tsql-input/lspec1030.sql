USE AdventureWorks;
GO
CREATE TABLE inventory22
(
	 part_id int IDENTITY(100, 1) NOT NULL,
	 description varchar(30) NOT NULL,
	 entry_person varchar(30) NOT NULL DEFAULT USER 
)
GO
INSERT inventory22 (description)
VALUES ('Red pencil')
INSERT inventory22 (description)
VALUES ('Blue pencil')
INSERT inventory22 (description)
VALUES ('Green pencil')
INSERT inventory22 (description)
VALUES ('Black pencil')
INSERT inventory22 (description)
VALUES ('Yellow pencil')
GO
