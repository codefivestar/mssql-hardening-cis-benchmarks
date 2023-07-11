----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2023-07-11
--Description   : Ensure user databases are encrypted using Transparent Data Encryption (TDE).
--                Backups of databases encrypted with TDE are automatically encrypted as well.
----------------------------------------------------------------------------------------------------------
USE [master]
GO

BEGIN -- >> Audit

    select database_id
         , name
         , is_encrypted 
      from sys.databases
     where database_id > 4 
       and is_encrypted != 1
    
    -- The query should return no rows

END

BEGIN -- >> Remediation


END