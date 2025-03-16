# const vars
$ServerName = "host\instance"  # replace with your SQL Server instance name
$DatabaseName = "DB_Name"  # replace with your database name
$BackupPath = "C:\backups\"  # create directory manually


# filename create
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupFileName = "$DatabaseName`_$Timestamp.bak"
$BackupFilePath = "$BackupPath$BackupFileName"

# generate backcup command
$SqlQuery = "BACKUP DATABASE [$DatabaseName] TO DISK = N'$BackupFilePath' WITH FORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, STATS = 10;"

# invoking backup
$SqlCmd = "sqlcmd -S $ServerName -Q `"$SqlQuery`" -b"

# run the command
Invoke-Expression $SqlCmd

# Cpost check 
if (Test-Path $BackupFilePath) {
    Write-Host "Backup completed successfully: $BackupFilePath"
} else {
    Write-Host "Backup failed. Check SQL Server logs for details."
}
