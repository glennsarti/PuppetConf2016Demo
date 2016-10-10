$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules"
$dncModulesDir = "$modulesDir\dotnetcore"

Push-Location $dncModulesDir
& bundle exec puppet facts --modulepath $modulesDir --debug
Pop-Location