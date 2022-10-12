----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-12
--Description   : Check documentation CIS_Microsoft_SQL_Server_2019_Benchmark_v1.2.0.pdf
----------------------------------------------------------------------------------------------------------

-->> Audit
SELECT S.name AS 'Audit Name'
	, CASE S.is_state_enabled
		WHEN 1
			THEN 'Y'
		WHEN 0
			THEN 'N'
		END AS 'Audit Enabled'
	, S.type_desc AS 'Write Location'
	, SA.name AS 'Audit Specification Name'
	, CASE SA.is_state_enabled
		WHEN 1
			THEN 'Y'
		WHEN 0
			THEN 'N'
		END AS 'Audit Specification Enabled'
	, SAD.audit_action_name
	, SAD.audited_result
FROM sys.server_audit_specification_details AS SAD
INNER JOIN sys.server_audit_specifications AS SA
	ON SAD.server_specification_id = SA.server_specification_id
INNER JOIN sys.server_audits AS S
	ON SA.audit_guid = S.audit_guid
WHERE SAD.audit_action_id IN (
		'CNAU'
		, 'LGFL'
		, 'LGSD'
		);






-->> Remediation
CREATE SERVER AUDIT TrackLogins TO APPLICATION_LOG;
GO

CREATE SERVER AUDIT SPECIFICATION TrackAllLogins
FOR SERVER AUDIT TrackLogins ADD (FAILED_LOGIN_GROUP)
	, ADD (SUCCESSFUL_LOGIN_GROUP)
	, ADD (AUDIT_CHANGE_GROUP)
WITH (STATE = ON);
GO

ALTER SERVER AUDIT TrackLogins
	WITH (STATE = ON);
GO