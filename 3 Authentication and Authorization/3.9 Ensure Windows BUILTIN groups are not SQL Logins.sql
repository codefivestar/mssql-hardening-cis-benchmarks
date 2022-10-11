----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-11
--Description   : Prior to SQL Server 2008, the BUILTIN\Administrators group was added as a SQL Server
--                login with sysadmin privileges during installation by default. 
--Rationale     : The BUILTIN groups (Administrators, Everyone, Authenticated Users, Guests, etc.) generally
--                contain very broad memberships which would not meet the best practice of ensuring only
--                the necessary users have been granted access to a SQL Server instance. 
--Impact        : Before dropping the BUILTIN group logins, ensure that alternative AD Groups or Windows
--                logins have been added with equivalent permissions. Otherwise, the SQL Server instance
--                may become totally inaccessible.
----------------------------------------------------------------------------------------------------------

-->> Audit

SELECT pr.[name]
     , pe.[permission_name]
     , pe.[state_desc]
FROM sys.server_principals      pr
    JOIN sys.server_permissions pe
        ON pr.principal_id = pe.grantee_principal_id
WHERE pr.name like 'BUILTIN%';





-- >> Remediation

-- 1. For each BUILTIN login, if needed create a more restrictive AD group containing only
-- the required user accounts.
-- 2. Add the AD group or individual Windows accounts as a SQL Server login and grant it
-- the permissions required.
-- 3. Drop the BUILTIN login using the syntax below after replacing <name> in [BUILTIN\<name>].

USE [master]
GO

DROP LOGIN [BUILTIN\<name>]
GO