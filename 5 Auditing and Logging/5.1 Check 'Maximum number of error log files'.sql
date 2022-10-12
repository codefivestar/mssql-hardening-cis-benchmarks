----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-12
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf
----------------------------------------------------------------------------------------------------------

-->> Audit
--Run the following T-SQL. The NumberOfLogFiles returned should be greater than or equal to 12.

DECLARE @NumErrorLogs int;

EXEC master.sys.xp_instance_regread N'HKEY_LOCAL_MACHINE'
                                  , N'Software\Microsoft\MSSQLServer\MSSQLServer'
                                  , N'NumErrorLogs'
                                  , @NumErrorLogs OUTPUT;

SELECT ISNULL(@NumErrorLogs, -1) AS [NumberOfLogFiles];





-->> Remediation
--Run the following T-SQL to change the number of error log files, replace <NumberAbove12> with your desired number of error log files:

EXEC master.sys.xp_instance_regwrite N'HKEY_LOCAL_MACHINE'
                                   , N'Software\Microsoft\MSSQLServer\MSSQLServer'
                                   , N'NumErrorLogs'
                                   , REG_DWORD
                                   , <NumberAbove12>;
