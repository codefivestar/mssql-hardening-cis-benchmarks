----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-13
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf
----------------------------------------------------------------------------------------------------------

-->> Audit
USE <database_name>;
GO

SELECT name,
permission_set_desc
FROM sys.assemblies
WHERE is_user_defined = 1;




-->> Remediation
USE <database_name>;
GO

ALTER ASSEMBLY <assembly_name> WITH PERMISSION_SET = SAFE;