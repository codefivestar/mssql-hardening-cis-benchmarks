----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : Remove the right of the guest user to connect to SQL Server databases, except for master,
--                msdb, and tempdb.
--Rationale     : A login assumes the identity of the guest user when a login has access to SQL Server but
--                does not have access to a database through its own account and the database has a guest
--                user account.
----------------------------------------------------------------------------------------------------------
USE <database_name>;
GO

BEGIN -- >> Audit

    SELECT DB_NAME() AS DatabaseName
         , 'guest' AS Database_User
         , [permission_name]
         , [state_desc]
      FROM sys.database_permissions
     WHERE [grantee_principal_id] = DATABASE_PRINCIPAL_ID('guest')
       AND [state_desc] LIKE 'GRANT%'
       AND [permission_name] = 'CONNECT'
       AND DB_NAME() NOT IN ('master','tempdb','msdb');

    -- No rows should be returned. On AWS RDS instance, if only rdsadmin is returned, this is a pass.

END

BEGIN -- >> Remediation

    REVOKE CONNECT FROM guest;

END
