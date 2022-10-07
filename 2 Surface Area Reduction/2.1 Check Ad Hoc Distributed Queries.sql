----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : Enabling Ad Hoc Distributed Queries allows users to query data and execute statements on
--                external data sources. This functionality should be disabled.
----------------------------------------------------------------------------------------------------------

-- >> Audit

SELECT name
     , CAST(value as int)        as value_configured
     , CAST(value_in_use as int) as value_in_use
  FROM sys.configurations
 WHERE name = 'Ad Hoc Distributed Queries';





-- >> Remediation:

EXECUTE sp_configure 'show advanced options', 1;
RECONFIGURE;
EXECUTE sp_configure 'Ad Hoc Distributed Queries', 0;
RECONFIGURE;
GO
EXECUTE sp_configure 'show advanced options', 0;
RECONFIGURE;