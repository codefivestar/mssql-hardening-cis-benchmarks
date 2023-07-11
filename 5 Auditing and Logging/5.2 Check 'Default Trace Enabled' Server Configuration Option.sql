----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-12
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf
----------------------------------------------------------------------------------------------------------

USE [master]
GO

BEGIN -- >> Audit

   SELECT name
        , CAST(value as int) as value_configured
        , CAST(value_in_use as int) as value_in_use
     FROM sys.configurations
    WHERE name = 'default trace enabled';

END

BEGIN -- >> Remediation

   EXECUTE sp_configure 'show advanced options', 1;
   RECONFIGURE;

   EXECUTE sp_configure 'default trace enabled', 1;
   RECONFIGURE;
   GO

   EXECUTE sp_configure 'show advanced options', 0;
   RECONFIGURE;

END
