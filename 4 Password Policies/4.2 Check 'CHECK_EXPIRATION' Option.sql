----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-12
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf, page - 73
----------------------------------------------------------------------------------------------------------

-->> Audit
--Run the following T-SQL statement to find sysadmin or equivalent logins with CHECK_EXPIRATION = OFF. 
--No rows should be returned.

SELECT l.[name]
     , 'sysadmin membership' AS 'Access_Method'
  FROM sys.sql_logins AS l
 WHERE IS_SRVROLEMEMBER('sysadmin', name) = 1
   AND l.is_expiration_checked <> 1
 
 UNION ALL

SELECT l.[name]
     , 'CONTROL SERVER' AS 'Access_Method'
  FROM sys.sql_logins             AS l
  JOIN sys.server_permissions AS p
    ON l.principal_id = p.grantee_principal_id
 WHERE p.type = 'CL'
   AND p.state IN ( 'G', 'W' )
   AND l.is_expiration_checked <> 1;





-->> Remediation
--For each <login_name> found by the Audit Procedure, execute the following T-SQL statement:

ALTER LOGIN [<login_name>] WITH CHECK_EXPIRATION = ON;