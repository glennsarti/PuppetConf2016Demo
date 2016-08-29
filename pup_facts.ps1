$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\..\modules"
$dncModulesDir = "$modulesDir\dotnetcore"

Push-Location $dncModulesDir
& bundle exec puppet facts --modulepath $modulesDir --debug
Pop-Location