----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2023-06-15
--Description   : The xp_cmdshell option controls whether the xp_cmdshell extended stored procedure can
--                be used by an authenticated SQL Server user to execute operating-system command shell
--                commands and return results as rows within the SQL client.
--Rationale     : The xp_cmdshell procedure is commonly used by attackers to read or write data to/from
--                the underlying Operating System of a database server.
-- Version      : MSSQL 2016
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

    SELECT name, containment, containment_desc, is_auto_close_on
      FROM sys.databases
     WHERE containment <> 0 
       and is_auto_close_on = 1;

END

BEGIN -- >> Remediation

    ALTER DATABASE <database_name> SET AUTO_CLOSE OFF;

END