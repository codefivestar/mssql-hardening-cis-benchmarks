----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2023-07-11
--Description   : Configuring and enabling network encryption ensures traffic between the application
--                and the database system is encrypted. This will ensure compliance to security
--                standards such as PCI DSS, which is required if connections are through a public
--                network.
--                Network encryption can be configured in SQL Server either with self-signed certificates
--                or TLS certificates.
----------------------------------------------------------------------------------------------------------
USE [master]
GO

BEGIN -- >> Audit

    -- Run the following T-SQL code against the Master database

    select distinct(encrypt_option) from sys.dm_exec_connections;
    
    -- A response of TRUE implies a pass

END

BEGIN -- >> Remediation


END