----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-12
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf, page - 73
----------------------------------------------------------------------------------------------------------

USE [master]
GO

BEGIN -->> Audit

   -- Use the following code snippet to determine the status of SQL Logins and if their password
   -- complexity is enforced.

   SELECT name
        , is_disabled
     FROM sys.sql_logins
    WHERE is_policy_checked = 0;

END

BEGIN -->> Remediation

   --For each <login_name> found by the Audit Procedure, execute the following T-SQL statement:

   ALTER LOGIN [<login_name>] WITH CHECK_POLICY = ON;

   --Note: In the case of AWS RDS do not perform this remediation for the Master account.

END

