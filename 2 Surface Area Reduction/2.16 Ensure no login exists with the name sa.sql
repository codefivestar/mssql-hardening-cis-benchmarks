----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The sa login (e.g. principal) is a widely known and often widely used SQL Server account.
--                Therefore, there should not be a login called sa even when the original sa login
--                (principal_id = 1) has been renamed.
--Rationale     : Enforcing this control reduces the probability of an attacker executing brute force attacks
--                against a well-known principal name.
----------------------------------------------------------------------------------------------------------


USE [master]
 GO

BEGIN -- >> Audit

    SELECT principal_id
         , name
      FROM sys.server_principals
     WHERE name = 'sa';

END

BEGIN -- >> Remediation

    -- If principal_id = 1 or the login owns database objects, rename the sa login
    ALTER LOGIN [sa] WITH NAME = <different_name>;
    GO

    -- If the login owns no database objects, then drop it
    -- Do NOT drop the login if it is principal_id = 1
    DROP LOGIN sa

END

