----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The Ole Automation Procedures option controls whether OLE Automation objects can be
--                instantiated within Transact-SQL batches. These are extended stored procedures that allow
--                SQL Server users to execute functions external to SQL Server.
--Rationale     : Enabling this option will increase the attack surface of SQL Server and allow users to
--                execute functions in the security context of SQL Server.
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

   SELECT name
      , CAST(value as int) as value_configured
      , CAST(value_in_use as int) as value_in_use
   FROM sys.configurations
   WHERE name = 'Ole Automation Procedures';

END

BEGIN -- >> Remediation

   EXECUTE sp_configure 'show advanced options', 1;
   RECONFIGURE;
   EXECUTE sp_configure 'Ole Automation Procedures', 0;
   RECONFIGURE;
   GO
   EXECUTE sp_configure 'show advanced options', 0;
   RECONFIGURE;

END