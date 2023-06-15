----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The Database Mail XPs option controls the ability to generate and transmit email
--                messages from SQL Server.
--Rationale     : Disabling the Database Mail XPs option reduces the SQL Server surface, eliminates a DOS
--                attack vector and channel to exfiltrate data from the database server to a remote host.
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

   SELECT name
      , CAST(value as int) as value_configured
      , CAST(value_in_use as int) as value_in_use
   FROM sys.configurations
   WHERE name = 'Database Mail XPs';

   -- Both value columns must show 0 to be compliant.

END   

BEGIN -- >> Remediation

   EXECUTE sp_configure 'show advanced options', 1;
   RECONFIGURE;
   EXECUTE sp_configure 'Database Mail XPs', 0;
   RECONFIGURE;
   GO
   
   EXECUTE sp_configure 'show advanced options', 0;
   RECONFIGURE;

END