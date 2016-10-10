$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules\dotnetcore"

Push-Location $modulesDir
& bundle exec rake -T
Write-Host "---------------------"
& bundle exec puppet --version
Pop-Location