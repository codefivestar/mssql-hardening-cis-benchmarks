----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-12
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf
----------------------------------------------------------------------------------------------------------

-->> Audit

EXEC xp_loginconfig 'audit level';

-- A config_value of failure indicates a server login auditing setting of Failed logins only.
-- If a config_value of all appears, then both failed and successful logins are being logged.
-- Both settings should also be considered valid, but as mentioned capturing successful logins
-- using this method creates lots of noise in the SQL Server Errorlog.





-->> Remediation

--1. Run:

EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE'
                        , N'Software\Microsoft\MSSQLServer\MSSQLServer'
                        , N'AuditLevel'
                        , REG_DWORD
                        , 2

--2. Restart the SQL Server instance.