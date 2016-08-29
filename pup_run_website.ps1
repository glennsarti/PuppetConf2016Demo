$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\..\modules"

& puppet apply "$srcDir\manifests\run_website.pp" --modulepath $modulesDir --debug
