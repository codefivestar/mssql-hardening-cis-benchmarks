----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : A database user for which the corresponding SQL Server login is undefined or is incorrectly
--                defined on a server instance cannot log in to the instance and is referred to as orphaned
--                and should be removed.
--Rationale     : Orphan users should be removed to avoid potential misuse of those broken users in any way.
----------------------------------------------------------------------------------------------------------

BEGIN

    BEGIN -- >> Audit

        BEGIN -- Script for Single Database
        
            USE <database_name>;
            GO

            EXEC sp_change_users_login @Action='Report';

        END

        BEGIN -- Script for All Databases

            SET NOCOUNT ON

            DECLARE @Databases TABLE (DbName VARCHAR(128))
            DECLARE @Audit     TABLE ( 
                                          ServerName NVARCHAR(128)
                                        , DbName     NVARCHAR(128)
                                        , UserName   SYSNAME
                                        , UserSID    VARBINARY(85)
                                        )
            DECLARE @sql      NVARCHAR(1000)
                  , @sqlCheck NVARCHAR(1000)
                  , @dbName   NVARCHAR(128)

                SET @sqlCheck = 'EXEC sp_change_users_login @Action = ''Report'''

                INSERT INTO @Databases (dbName)
                    SELECT [name]
                    FROM master.sys.databases 
                    WHERE state = 0

                    WHILE EXISTS (SELECT * FROM @Databases)
                        BEGIN
                        
                        SET @dbName = (SELECT TOP 1 dbName FROM @Databases)
                        SET @sql    = 'USE ' + @dbName + '; ' + @sqlCheck + ';' 

                        -- PRINT @sql;

                        INSERT INTO @Audit(UserName, UserSID)
                                EXEC (@sql)
                        
                        UPDATE @Audit 
                            SET ServerName = CONVERT(NVARCHAR(128), SERVERPROPERTY('ServerName'))
                            WHERE ServerName IS NULL

                        UPDATE @Audit
                            SET DbName = @dbName
                            WHERE DbName IS NULL

                        DELETE FROM @Databases 
                                WHERE dbName = @dbName
                        END

                        SELECT * FROM @Audit

        END

    END

    BEGIN -- >> Remediation

        USE <database_name>;
        GO

        DROP USER <username>;

    END

END

