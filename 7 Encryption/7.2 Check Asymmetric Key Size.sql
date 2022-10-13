----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-13
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf
----------------------------------------------------------------------------------------------------------

-->> Audit
USE <database_name>
GO

SELECT db_name() AS Database_Name, name AS Key_Name
FROM sys.asymmetric_keys
WHERE key_length < 2048
AND db_id() > 4;
GO




-->> Remediation
-- Refer to Microsoft SQL Server Books Online ALTER ASYMMETRIC KEY entry:
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-asymmetric-key-transact-sql