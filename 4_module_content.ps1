$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules"
$dncModulesDir = "$modulesDir\dotnetcore"

Copy-Item -Path "$srcDir\4_provider\dotnetcore" -Destination $modulesDir -Recurse -Confirm:$false -Force | Out-Null

Push-Location $dncModulesDir

#& git add --a
#& git commit -m "Initial code commit"

Pop-Location
