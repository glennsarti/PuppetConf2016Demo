$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules"

Push-Location $modulesDir

# & puppet module generate glennsarti-dotnetcore --skip-interview

cd "dotnetcore"

# & git init
# & git add --a
# & git commit -m "Initial commit"

Copy-Item "$srcDir\1_create\.gitignore" ".gitignore" -Force -Confirm:$false | Out-Null
# & git add --a
# & git commit -m "Updated gitignore"

Pop-Location