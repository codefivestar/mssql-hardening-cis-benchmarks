----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The remote admin connections option controls whether a client application on a remote
--                computer can use the Dedicated Administrator Connection (DAC).
--Rationale     : The Dedicated Administrator Connection (DAC) lets an administrator access a running
--                server to execute diagnostic functions or Transact-SQL statements, or to troubleshoot
--                problems on the server, even when the server is locked or running in an abnormal state
--                and not responding to a SQL Server Database Engine connection.
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

    USE master;
    GO
    SELECT name,
    CAST(value as int) as value_configured,
    CAST(value_in_use as int) as value_in_use
    FROM sys.configurations
    WHERE name = 'remote admin connections'
    AND SERVERPROPERTY('IsClustered') = 0;

END

BEGIN -- >> Remediation

    EXECUTE sp_configure 'remote admin connections', 0;
    RECONFIGURE;
    GO

END    