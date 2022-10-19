----------------------------------------------------------------------------------------------------------
--Author        : Hidequel Puga
--Date          : 2022-10-07
--Description   : The TRUSTWORTHY database option allows database objects to access objects in other
--                databases under certain circumstances.
--Rationale     : Provides protection from malicious CLR assemblies or extended procedures.
----------------------------------------------------------------------------------------------------------

BEGIN -- >> Audit

  SELECT TOP(1) local_tcp_port 
    FROM sys.dm_exec_connections
   WHERE local_tcp_port IS NOT NULL;

  SELECT local_tcp_port
    FROM sys.dm_exec_connections
   WHERE session_id = @@SPID


END

BEGIN-- >> Remediation

  -- 1. In SQL Server Configuration Manager, in the console pane, expand SQL Server
  --    Network Configuration, expand Protocols for <InstanceName>, and then double-
  --    click the TCP/IP protocol

  -- 2. In the TCP/IP Properties dialog box, on the IP Addresses tab, several IP addresses
  --    appear in the format IP1, IP2, up to IPAll. One of these is for the IP address of the
  --    loopback adapter, 127.0.0.1. Additional IP addresses appear for each IP Address on
  --    the computer.

  -- 3. Under IPAll, change the TCP Port field from 1433 to a non-standard port or leave
  --    the TCP Port field empty and set the TCP Dynamic Ports value to 0 to enable
  --    dynamic port assignment and then click OK.

  -- 4. In the console pane, click SQL Server Services.

  -- 5. In the details pane, right-click SQL Server (<InstanceName>) and then click
  --    Restart, to stop and restart SQL Server.

END