$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules\dotnetcore"

Push-Location $modulesDir
bundle install --path .bundle\gems --without system_tests
Pop-Location