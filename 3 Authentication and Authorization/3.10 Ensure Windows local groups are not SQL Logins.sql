----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-11
--Description   : Local Windows groups should not be used as logins for SQL Server instances.
--Rationale     : Allowing local Windows groups as SQL Logins provides a loophole whereby anyone with
--                OS level administrator rights (and no SQL Server rights) could add users to the local
--                Windows groups and thereby give themselves or others access to the SQL Server instance.
--Impact        : Before dropping the local group logins, ensure that alternative AD Groups or Windows
--                logins have been added with equivalent permissions. Otherwise, the SQL Server instance
--                may become totally inaccessible.
----------------------------------------------------------------------------------------------------------

USE [master]
GO

BEGIN -->> Audit

  -- Use the following syntax to determine if any local groups have been added as SQL Server Logins.

  SELECT pr.[name] AS LocalGroupName, pe.[permission_name], pe.[state_desc]
    FROM sys.server_principals pr
    JOIN sys.server_permissions pe
      ON pr.[principal_id] = pe.[grantee_principal_id]
   WHERE pr.[type_desc] = 'WINDOWS_GROUP'
     AND pr.[name] LIKE CAST(SERVERPROPERTY('MachineName') AS NVARCHAR) + '%';

  -- This query should not return any rows

END

BEGIN -->> Remediation

  -- 1. For each LocalGroupName login, if needed create an equivalent AD group containing
  -- only the required user accounts.
  -- 2. Add the AD group or individual Windows accounts as a SQL Server login and grant it
  -- the permissions required.
  -- 3. Drop the LocalGroupName login using the syntax below after replacing <name>.

  DROP LOGIN [<name>]
  GO

END
