SELECT TYPEPROPERTY(SCHEMA_NAME(schema_id) + '.' + name, 'OwnerId') AS owner_id, name, system_type_id, user_type_id, schema_id
FROM sys.types;

SELECT TYPEPROPERTY( 'tinyint', 'PRECISION');

