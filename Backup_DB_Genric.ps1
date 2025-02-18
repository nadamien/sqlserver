# Automation Ops
# MSSQL Backup from Container
# Windows based
param (
    [string]$CONTAINER_NAME,
    [string]$DATABASE_NAME,
    [string]$SA_PASSWORD 
)

if (-not $CONTAINER_NAME) {
    Write-Host "Usage: $0 [container name] [database name] [SA password]"
    exit 1
}

if (-not $DATABASE_NAME) {
    Write-Host "Usage: $0 [container name] [database name] [SA password]"
    exit 1
}

if (-not $SA_PASSWORD) {
    Write-Host "Usage: $0 [container name] [database name] [SA password]"
    exit 1
}

$ErrorActionPreference = "Stop"

$FILE_NAME = (Get-Date -Format "yy-MM-dd_HH") + ".$DATABASE_NAME.bak"

if (-not (Test-Path "C:\backups")) {
    New-Item -ItemType Directory -Path "C:\backups" | Out-Null
}


Write-Host "Backing up database '$DATABASE_NAME' from container '$CONTAINER_NAME'..."

#mssql tool location may differ
docker exec -it "$CONTAINER_NAME" /opt/mssql-tools18/bin/sqlcmd -b -V16 -S localhost -U SA -P "$SA_PASSWORD" -Q "BACKUP DATABASE [$DATABASE_NAME] TO DISK = N'/var/opt/mssql/backups/$FILE_NAME' with NOFORMAT, NOINIT, NAME = '$DATABASE_NAME-full', SKIP, NOREWIND, NOUNLOAD, STATS = 10" -N -C

Write-Host ""
Write-Host "Exporting file from container..."

# copy the created file out of the container to the host filesystem
docker cp "$CONTAINER_NAME`:/var/opt/mssql/backups/$FILE_NAME" "C:\backups\"

Write-Host "Backed up database '$DATABASE_NAME' to C:\backups\$FILE_NAME"
Write-Host "Done!"