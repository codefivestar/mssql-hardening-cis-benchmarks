----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The clr enabled option specifies whether user assemblies can be run by SQL Server.
--                Enabling use of CLR assemblies widens the attack surface of SQL Server and puts it at risk
--                from both inadvertent and malicious assemblies.
----------------------------------------------------------------------------------------------------------

BEGIN

   BEGIN -- >> Impact

      BEGIN -- Script for Single Database

         USE [<database_name>]
         GO

         SELECT name AS Assembly_Name
              , permission_set_desc
           FROM sys.assemblies
          WHERE is_user_defined = 1;
         GO

      END

      BEGIN -- Script for All Databases

         SET NOCOUNT ON

         DECLARE @Databases TABLE (dbName NVARCHAR(128))
         DECLARE @Impact    TABLE (
                                     DbName                NVARCHAR(128)
                                   , AssemblyName          NVARCHAR(128)
                                   , DescriptionPermission NVARCHAR(50)
                                   )
         DECLARE @sql       NVARCHAR(1000)    
               , @sqlCheck  NVARCHAR(1000)    
               , @dbName    NVARCHAR(128)    

             SET @sqlCheck = 'SELECT db_name()           AS DbName
                                   , name                AS AssemblyName
                                   , permission_set_desc AS DescriptionPermission 
                                FROM sys.assemblies 
                               WHERE is_user_defined = 1'

         INSERT INTO @Databases (dbName)
              SELECT [name]
                FROM master.sys.databases

         WHILE EXISTS (SELECT * FROM @Databases)
            BEGIN
               
               SET @dbName = (SELECT TOP 1 dbName FROM @Databases)
               SET @sql    = 'USE [' + @dbName + ']; ' + @sqlCheck + ';' 

               -- PRINT @sql;

               INSERT INTO @Impact(DbName, AssemblyName, DescriptionPermission)
                      EXEC (@sql)

               DELETE FROM @Databases 
                     WHERE dbName = @dbName
            END

         SELECT * FROM @Impact

      END

   END

   BEGIN -- >> Audit

      SELECT name
           , CAST(value as int)        as value_configured
           , CAST(value_in_use as int) as value_in_use
        FROM sys.configurations
       WHERE name = 'clr strict security';

      --If both values are 1, this recommendation is Not Applicable. Otherwise, run the following T-SQL command:

      SELECT name
           , CAST(value as int)        as value_configured
           , CAST(value_in_use as int) as value_in_use
        FROM sys.configurations
       WHERE name = 'clr enabled';

      --Both value columns must show 0 to be compliant.

   END

   BEGIN -- >> Remediation
      
      EXECUTE sp_configure 'clr enabled', 0;
      RECONFIGURE;

   END

END
