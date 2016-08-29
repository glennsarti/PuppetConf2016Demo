$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\..\modules"
$dncModulesDir = "$modulesDir\dotnetcore"

Copy-Item -Path "$srcDir\6_tests\dotnetcore" -Destination $modulesDir -Recurse -Confirm:$false -Force | Out-Null

Push-Location $dncModulesDir

& git add --a
& git commit -m "Add tests"

Pop-Location
