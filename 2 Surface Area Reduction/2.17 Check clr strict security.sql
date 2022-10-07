----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The clr strict security option specifies whether the engine applies the PERMISSION_SET
--                on the assemblies.
--Rationale     : Enabling use of CLR assemblies widens the attack surface of SQL Server and puts it at risk
--                from both inadvertent and malicious assemblies.
----------------------------------------------------------------------------------------------------------

-- >> Check if CLR assemblies are in use

USE [<database_name>]
GO
SELECT name AS Assembly_Name, permission_set_desc
FROM sys.assemblies
WHERE is_user_defined = 1;
GO





-- >> Audit

SELECT name,
CAST(value as int) as value_configured,
CAST(value_in_use as int) as value_in_use
FROM sys.configurations
WHERE name = 'clr strict security';





-- >> Remediation

EXECUTE sp_configure 'show advanced options', 1;
RECONFIGURE;
EXECUTE sp_configure 'clr strict security', 1;
RECONFIGURE;
GO
EXECUTE sp_configure 'show advanced options', 0;
RECONFIGURE;