----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The sa account is a widely known and often widely used SQL Server account with sysadmin
--                privileges. This is the original login created during installation and always has the
--                principal_id=1 and sid=0x01.
--Rationale     : Enforcing this control reduces the probability of an attacker executing brute force attacks
--                against a well-known principal.
----------------------------------------------------------------------------------------------------------

BEGIN-- >> Audit

    SELECT name, is_disabled
    FROM sys.server_principals
    WHERE sid = 0x01
    AND is_disabled = 0;

    -- No rows should be returned to be compliant.
    -- An is_disabled value of 0 indicates the login is currently enabled and therefore needs
    -- remediation.

END

BEGIN -- >> Remediation

    USE [master]
    GO

    DECLARE @tsql nvarchar(max)

    SET @tsql = 'ALTER LOGIN ' + SUSER_NAME(0x01) + ' DISABLE'

    EXEC (@tsql)
    GO

END

