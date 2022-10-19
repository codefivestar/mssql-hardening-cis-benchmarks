----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : AUTO_CLOSE determines if a given database is closed or not after a connection terminates. If
--                enabled, subsequent connections to the given database will require the database to be
--                reopened and relevant procedure caches to be rebuilt.
--Rationale     : Because authentication of users for contained databases occurs within the database not at
--                the server\instance level, the database must be opened every time to authenticate a user.
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

    SELECT name, containment, containment_desc, is_auto_close_on
    FROM sys.databases
    WHERE containment <> 0 and is_auto_close_on = 1;

END

BEGIN -- >> Remediation

    ALTER DATABASE <database_name> SET AUTO_CLOSE OFF;

END