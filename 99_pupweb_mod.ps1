$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\modules"
$webModulesDir = "$modulesDir\puppetconf_website"

Copy-Item -Path "$srcDir\99_pupweb_mod\puppetconf_website" -Destination $modulesDir -Recurse -Confirm:$false -Force | Out-Null
