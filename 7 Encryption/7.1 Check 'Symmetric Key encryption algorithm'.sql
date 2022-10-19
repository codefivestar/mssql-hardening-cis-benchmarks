----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-13
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

    USE <database_name>
    GO

    SELECT db_name() AS Database_Name
         , name AS Key_Name
      FROM sys.symmetric_keys
     WHERE algorithm_desc NOT IN ('AES_128','AES_192','AES_256')
       AND db_id() > 4;
    GO

END

BEGIN -->> Remediation

    -- Refer to Microsoft SQL Server Books Online ALTER SYMMETRIC KEY entry:
    -- https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-symmetric-key-transact-sql

END
