$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\..\modules\dotnetcore"

Push-Location $modulesDir
bundle install --path .bundle\gems --without system_tests
Pop-Location