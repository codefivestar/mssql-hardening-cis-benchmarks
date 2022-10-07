----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The scan for startup procs option, if enabled, causes SQL Server to scan for and
--                automatically run all stored procedures that are set to execute upon service startup.
--Rationale     : Enforcing this control reduces the threat of an entity leveraging these facilities for
--                malicious purposes.
----------------------------------------------------------------------------------------------------------

-- >> Audit

SELECT name,
CAST(value as int) as value_configured,
CAST(value_in_use as int) as value_in_use
FROM sys.configurations
WHERE name = 'scan for startup procs';





-- >> Remediation

EXECUTE sp_configure 'show advanced options', 1;
RECONFIGURE;
EXECUTE sp_configure 'scan for startup procs', 0;
RECONFIGURE;
GO
EXECUTE sp_configure 'show advanced options', 0;
RECONFIGURE;