----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : Enabling Ad Hoc Distributed Queries allows users to query data and execute statements on
--                external data sources. This functionality should be disabled.
----------------------------------------------------------------------------------------------------------
USE [master]
GO

BEGIN -- >> Audit

    SELECT b.key_algorithm
	     , b.encryptor_type
	     , d.is_encrypted
	     , b.database_name
	     , b.server_name
      FROM msdb.dbo.backupset b
INNER JOIN sys.databases d
	    ON b.database_name = d.name
     WHERE b.key_algorithm IS NULL
	   AND b.encryptor_type IS NULL
	   AND d.is_encrypted = 0;  

-- No rows should be returned by the query

END

BEGIN -- >> Remediation


END