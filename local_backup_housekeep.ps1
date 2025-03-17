$BackupPath = "C:\backups\"  # Change this to your backup directory
$ArchivePath = "C:\backups\Archives\"  # Change this to your archive directory

# Ensure the archive directory exists
if (!(Test-Path $ArchivePath)) {
    New-Item -ItemType Directory -Path $ArchivePath | Out-Null
}

# get the date for filtering old backup files (2 days ago)
$OldDate = (Get-Date).AddDays(-2)

# get .bak files older than 2 days
$OldBackupFiles = Get-ChildItem -Path $BackupPath -Filter "*.bak" | Where-Object { $_.LastWriteTime -lt $OldDate }

# zip logic
if ($OldBackupFiles.Count -gt 0) {
    # Create a ZIP file with timestamp
    $ZipFileName = "SQLBackups_$((Get-Date).ToString('yyyyMMdd_HHmmss')).zip"
    $ZipFilePath = "$ArchivePath$ZipFileName"

    # compress the old backups
    Compress-Archive -Path $OldBackupFiles.FullName -DestinationPath $ZipFilePath

    # arch location zip file check if its created
    if (Test-Path $ZipFilePath) {
        # delete the original .bak files after successful compression
        $OldBackupFiles | Remove-Item -Force
        Write-Host "Old backups successfully compressed and deleted. Archive: $ZipFilePath"
    } else {
        Write-Host "Backup compression failed."
    }
} else {
    Write-Host "No old backups found to compress."
}
