SELECT    DISTINCT -- Make sure we don't get duplicates
    'EXEC ' + db_name() 
	+ '.dbo.sp_change_users_login ''Update_One'', '
	+ '''' + U.name + ''', '
	+ '''' + U.name + '''' AS DeOrphanizeStatement
FROM    sys.database_principals AS U
	LEFT OUTER JOIN sys.sql_logins AS L 
		ON L.[name] = U.[name] COLLATE SQL_Latin1_General_CP1_CI_AS --Ensures no Case problems
where    (U.type = 'S') --SQL Logins Only; no Windows Logins, no Roles
	AND U.name NOT IN ('dbo')
	AND U.sid IS NOT NULL --Eliminates INFORMATION_SCHEMA and PUBLIC
	AND U.name NOT IN ('guest') --Eliminates specific unwanted logins


