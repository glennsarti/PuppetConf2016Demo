$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules\dotnetcore"

Push-Location $modulesDir
& bundle exec rake spec
Pop-Location