----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : Functionality can be abused to launch a Denial-of-Service (DoS) attack on remote servers
--                by off-loading query processing to a target.
--Rationale     : Per Microsoft: This feature will be removed in the next version of Microsoft SQL Server. Do
--                not use this feature in new development work, and modify applications that currently use
--                this feature as soon as possible. Use sp_addlinkedserver instead.
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

   SELECT name
      , CAST(value as int) as value_configured
      , CAST(value_in_use as int) as value_in_use
   FROM sys.configurations
   WHERE name = 'remote access';

   -- Both value columns must show 0.

END

BEGIN -- >> Remediation

   EXECUTE sp_configure 'show advanced options', 1;
   RECONFIGURE;
   EXECUTE sp_configure 'remote access', 0;
   RECONFIGURE;
   GO

END   