$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\..\modules\dotnetcore"

Push-Location $modulesDir
& bundle exec rake -T
Write-Host "---------------------"
& bundle exec puppet --version
Pop-Location