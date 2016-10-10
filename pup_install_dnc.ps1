$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules"
$dncModulesDir = "$modulesDir\dotnetcore"

Push-Location $dncModulesDir
& bundle exec puppet apply "$srcDir\manifests\install_dnc.pp" --modulepath $modulesDir
Pop-Location