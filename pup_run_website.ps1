$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules"

& puppet apply "$srcDir\manifests\run_website.pp" --modulepath $modulesDir --debug
