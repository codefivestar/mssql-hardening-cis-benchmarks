----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-11
--Description   : public is a special fixed server role containing all logins. Unlike other fixed server roles,
--                permissions can be changed for the public role. In keeping with the principle of least
--                privileges, the public server role should not be used to grant permissions at the server
--                scope as these would be inherited by all users.
--Rationale     : Every SQL Server login belongs to the public role and cannot be removed from this role.
--                Therefore, any permissions granted to this role will be available to all logins unless they
--                have been explicitly denied to specific logins or user-defined server roles.
--Impact        : When the extraneous permissions are revoked from the public server role, access may be
--                lost unless the permissions are granted to the explicit logins or to user-defined server roles
--                containing the logins which require the access.
----------------------------------------------------------------------------------------------------------

BEGIN -->> Audit

      -- Use the following syntax to determine if extra permissions have been granted to the public
      -- server role.

      SELECT * 
      FROM master.sys.server_permissions
      WHERE (   grantee_principal_id = SUSER_SID(N'public')
      and   state_desc LIKE 'GRANT%')
      AND NOT (   state_desc = 'GRANT'
            and   [permission_name] = 'VIEW ANY DATABASE'
            and   class_desc = 'SERVER')
      AND NOT (   state_desc = 'GRANT'
            and   [permission_name] = 'CONNECT'
            and   class_desc = 'ENDPOINT'
            and   major_id = 2)
      AND NOT (   state_desc = 'GRANT'
            and   [permission_name] = 'CONNECT'
            and   class_desc = 'ENDPOINT'
            and   major_id = 3)
      AND NOT (   state_desc = 'GRANT'
            and   [permission_name] = 'CONNECT'
            and   class_desc = 'ENDPOINT'
            and   major_id = 4)
      AND NOT (   state_desc = 'GRANT'
            and   [permission_name] = 'CONNECT'
            and   class_desc = 'ENDPOINT'
            and   major_id = 5);

END            

BEGIN -->> Remediation

      -- 1. Add the extraneous permissions found in the Audit query results to the specific
      -- logins to user-defined server roles which require the access.
      -- 2. Revoke the <permission_name> from the public role as shown below

      USE [master]
      GO

      REVOKE <permission_name> FROM public;
      GO

END