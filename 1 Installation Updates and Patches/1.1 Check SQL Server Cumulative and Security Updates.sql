----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : SQL Server patches contain program updates that fix security and product functionality
--                issues found in the software.
----------------------------------------------------------------------------------------------------------
USE [master]
GO

BEGIN -- >> Audit

     SELECT SERVERPROPERTY('ProductLevel') AS SP_installed
          , SERVERPROPERTY('ProductVersion') AS Version
          , SERVERPROPERTY('ProductUpdateLevel') AS 'ProductUpdate_Level'
          , SERVERPROPERTY('ProductUpdateReference') AS 'KB_Number';

END

BEGIN -- >> Remediation

-- Identify the current version and patch level of your SQL Server instances and ensure they
-- contain the latest security fixes. Make sure to test these fixes in your test environments
-- before updating production instances.
-- The most recent SQL Server patches can be found here:     

-- link # 1 : https://learn.microsoft.com/en-us/sql/database-engine/install-windows/latest-updates-for-microsoft-sql-server?view=sql-server-ver15

END
