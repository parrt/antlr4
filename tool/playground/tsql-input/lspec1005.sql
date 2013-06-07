IF ( (SELECT TRIGGER_NESTLEVEL( OBJECT_ID('xyz') , 'AFTER' , 'DML' ) ) > 5 )
	   RAISERROR('Trigger xyz nested more than 5 levels.',16,-1)

IF ( ( SELECT TRIGGER_NESTLEVEL ( ( SELECT object_id FROM sys.triggers
	WHERE name = 'abc' ), 'AFTER' , 'DDL' ) ) > 5 )
	   RAISERROR ('Trigger abc nested more than 5 levels.',16,-1)

IF ( (SELECT trigger_nestlevel() ) > 5 )
	   RAISERROR
	      ('This statement nested over 5 levels of triggers.',16,-1)


