----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : Non-clustered SQL Server instances within production environments should be designated
--                as hidden to prevent advertisement by the SQL Server Browser service.
--Rationale     : Designating production SQL Server instances as hidden leads to a more secure installation
--                because they cannot be enumerated.
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit
	DECLARE @getValue INT;

	EXEC master.sys.xp_instance_regread @rootkey    = N'HKEY_LOCAL_MACHINE'
                                      , @key        = N'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib'
                                      , @value_name = N'HideInstance'
                                      , @value      = @getValue OUTPUT;

	SELECT @getValue;
END

BEGIN -- >> Remediation
	EXEC master.sys.xp_instance_regwrite @rootkey    = N'HKEY_LOCAL_MACHINE'
                                       , @key        = N'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib'
                                       , @value_name = N'HideInstance'
                                       , @type       = N'REG_DWORD'
                                       , @value      = 1;
END