----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The cross db ownership chaining option controls cross-database ownership chaining
--                across all databases at the instance (or server) level.
--Rationale     : When enabled, this option allows a member of the db_owner role in a database to gain
--                access to objects owned by a login in any other database, causing an unnecessary
--                information disclosure.
----------------------------------------------------------------------------------------------------------

-- >> Audit

SELECT name
     , CAST(value as int)        as value_configured
     , CAST(value_in_use as int) as value_in_use
  FROM sys.configurations
 WHERE name = 'cross db ownership chaining';





-- >> Remediation

EXECUTE sp_configure 'cross db ownership chaining', 0;
RECONFIGURE;
GO