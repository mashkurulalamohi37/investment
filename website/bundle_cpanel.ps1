# Swapnojatri cPanel Deployment Bundler
$ErrorActionPreference = "Stop"

Write-Host "Creating cPanel production bundle..." -ForegroundColor Cyan

$zipName = "swapnojatri_cpanel_deploy.zip"
$tempDir = Join-Path $PSScriptRoot "cpanel_bundle_temp"
$zipFile = Join-Path $PSScriptRoot $zipName

if (Test-Path $zipFile) {
    Remove-Item -Force $zipFile
}
if (Test-Path $tempDir) {
    Remove-Item -Recurse -Force $tempDir
}

New-Item -ItemType Directory -Path $tempDir | Out-Null

Write-Host "Copying files to temporary bundle folder..." -ForegroundColor Cyan
Copy-Item -Recurse -Path (Join-Path $PSScriptRoot ".next") -Destination (Join-Path $tempDir ".next")
Copy-Item -Recurse -Path (Join-Path $PSScriptRoot "public") -Destination (Join-Path $tempDir "public")
Copy-Item -Recurse -Path (Join-Path $PSScriptRoot "src") -Destination (Join-Path $tempDir "src")
Copy-Item -Path (Join-Path $PSScriptRoot "server.js") -Destination $tempDir
Copy-Item -Path (Join-Path $PSScriptRoot "package.json") -Destination $tempDir
Copy-Item -Path (Join-Path $PSScriptRoot "package-lock.json") -Destination $tempDir
Copy-Item -Path (Join-Path $PSScriptRoot "next.config.js") -Destination $tempDir
Copy-Item -Path (Join-Path $PSScriptRoot ".env.production") -Destination $tempDir
if (Test-Path (Join-Path $PSScriptRoot ".htaccess")) {
    Copy-Item -Path (Join-Path $PSScriptRoot ".htaccess") -Destination $tempDir
}

Write-Host "Compressing archive to $zipName..." -ForegroundColor Cyan
Compress-Archive -Path "$tempDir\*" -DestinationPath $zipFile -CompressionLevel Optimal

Remove-Item -Recurse -Force $tempDir

Write-Host "cPanel bundle created successfully at: $zipFile" -ForegroundColor Green
