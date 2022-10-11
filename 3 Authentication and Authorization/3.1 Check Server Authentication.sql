----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : Uses Windows Authentication to validate attempted connections.
--Rationale     : Windows provides a more robust authentication mechanism than SQL Server authentication.
----------------------------------------------------------------------------------------------------------

-- >> Audit

SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') as [login_mode];





-- >> Remediation

USE [master]
GO

EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE'
                        , N'Software\Microsoft\MSSQLServer\MSSQLServer'
                        , N'LoginMode'
                        , REG_DWORD
                        , 1
GO