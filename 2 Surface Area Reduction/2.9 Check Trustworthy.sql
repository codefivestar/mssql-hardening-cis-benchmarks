----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The TRUSTWORTHY database option allows database objects to access objects in other
--                databases under certain circumstances.
--Rationale     : Provides protection from malicious CLR assemblies or extended procedures.
----------------------------------------------------------------------------------------------------------

BEGIN-- >> Audit

    SELECT name
    FROM sys.databases
    WHERE is_trustworthy_on = 1
    AND name != 'msdb';

    -- No rows should be returned.


END

BEGIN-- >> Remediation

    ALTER DATABASE [<database_name>] SET TRUSTWORTHY OFF;
    
END

