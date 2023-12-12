----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-12
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf, page - 71
----------------------------------------------------------------------------------------------------------

BEGIN-->> Audit

    --Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.3.0.pdf, pages : 78-79

END

BEGIN -- >> Remediation

    --Set the MUST_CHANGE option for SQL Authenticated logins when creating a login initially:
    CREATE LOGIN <login_name> WITH PASSWORD = '<password_value>' MUST_CHANGE
                                            , CHECK_EXPIRATION = ON
                                            , CHECK_POLICY     = ON;

    --Set the MUST_CHANGE option for SQL Authenticated logins when resetting a password:
    ALTER LOGIN <login_name> WITH PASSWORD = '<new_password_value>' MUST_CHANGE;                                         

END
