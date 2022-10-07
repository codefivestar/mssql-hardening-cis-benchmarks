----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The clr enabled option specifies whether user assemblies can be run by SQL Server.
--                Enabling use of CLR assemblies widens the attack surface of SQL Server and puts it at risk
--                from both inadvertent and malicious assemblies.
----------------------------------------------------------------------------------------------------------

-- >> Check if CLR assemblies are in use

USE [<database_name>]
GO

SELECT name                AS Assembly_Name
     , permission_set_desc
  FROM sys.assemblies
 WHERE is_user_defined = 1;
GO





-- >> Audit

SELECT name
     , CAST(value as int)        as value_configured
     , CAST(value_in_use as int) as value_in_use
  FROM sys.configurations
 WHERE name = 'clr strict security';

 SELECT name
      , CAST(value as int) as value_configured
      , CAST(value_in_use as int) as value_in_use
   FROM sys.configurations
  WHERE name = 'clr enabled';





-- >> Remediation  

EXECUTE sp_configure 'clr enabled', 0;
RECONFIGURE;