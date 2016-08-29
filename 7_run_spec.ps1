$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\..\modules\dotnetcore"

Push-Location $modulesDir
& bundle exec rake spec
Pop-Location