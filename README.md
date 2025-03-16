SQL Server Backup Scripts
=========================

1) Backup_DB_Genric.ps1 is a Script Which can be used to backup SQL server databases on Docker containers.

Script will take 3 input parameetrs.

i.e. Backup_DB_Genric.ps1 "container name" "database name" "SA password"

2) Generic backup, no inpur parms, you can schedule this in Windows Task Scheduler to automate the backups.

Run the local_backup.ps1 on powershell, this will invoke a full backup of the database specified.

Bellow constant varibles should be changed, accrodingly.

$ServerName = "host\instance"  # Replace with your SQL Server instance name
$DatabaseName = "DB_Name"  # Replace with your database name
$BackupPath = "C:\backups\"  # Ensure this directory exists


1.e. local_backup.ps1

