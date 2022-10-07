----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The sa account is a widely known and often widely used SQL Server login with sysadmin
--                privileges. The sa login is the original login created during installation and always has
--                principal_id=1 and sid=0x01.
--Rationale     : It is more difficult to launch password-guessing and brute-force attacks against the sa login
--                if the name is not known.
----------------------------------------------------------------------------------------------------------

-- >> Audit

SELECT name
FROM sys.server_principals
WHERE sid = 0x01;





-- >> Remediation

ALTER LOGIN sa WITH NAME = <different_user>;