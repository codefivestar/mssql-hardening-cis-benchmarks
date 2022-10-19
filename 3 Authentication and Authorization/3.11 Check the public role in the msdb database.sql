----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-11
--Description   : The public database role contains every user in the msdb database. SQL Agent proxies
--                define a security context in which a job step can run.
--Rationale     : Granting access to SQL Agent proxies for the public role would allow all users to utilize the
--                proxy which may have high privileges. This would likely break the principle of least
--                privileges.
--Impact        : Before revoking the public role from the proxy, ensure that alternative logins or
--                appropriate user-defined database roles have been added with equivalent permissions.
--                Otherwise, SQL Agent job steps dependent upon this access will fail.
----------------------------------------------------------------------------------------------------------

BEGIN -->> Audit

  -- Use the following syntax to determine if access to any proxies have been granted to the
  -- msdb database's public role.
  -- ** This query should not return any rows.

  USE [msdb]
  GO

  SELECT sp.name AS proxyname
    FROM dbo.sysproxylogin spl
    JOIN sys.database_principals dp
      ON dp.sid = spl.sid
    JOIN sysproxies sp
      ON sp.proxy_id = spl.proxy_id
  WHERE principal_id = USER_ID('public');
  GO

END

BEGIN -->> Remediation

  -- 1. Ensure the required security principals are explicitly granted access to the proxy
  -- (use sp_grant_login_to_proxy).
  -- 2. Revoke access to the <proxyname> from the public role.

  USE [msdb]
  GO

  EXEC dbo.sp_revoke_login_from_proxy @name       = N'public'
                                    , @proxy_name = N'<proxyname>';
  GO

END
