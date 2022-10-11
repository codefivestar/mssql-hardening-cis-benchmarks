----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : Contained databases do not enforce password complexity rules for SQL Authenticated users.
--Rationale     : The absence of an enforced password policy may increase the likelihood of a weak
--                credential being established in a contained database.
----------------------------------------------------------------------------------------------------------

-- >> Audit

SELECT name AS DBUser
  FROM sys.database_principals
 WHERE name NOT IN ('dbo', 'Information_Schema', 'sys', 'guest')
   AND type IN ('U', 'S', 'G')
   AND authentication_type = 2;
GO





-- >> Remediation

-- Leverage Windows Authenticated users in contained databases