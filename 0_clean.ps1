$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "$srcDir\..\modules"

if (Test-Path -Path $modulesDir) {
  # Stupid symlinks
  & cmd /c rd $modulesDir /s/q
}

New-Item -Path $modulesDir -ItemType Directory | Out-Null

#& puppet module install "$srcDir\0_dep_modules\puppetlabs-powershell-2.0.2.tar.gz" --ignore-dependencies --modulepath $modulesDir
#& puppet module install "$srcDir\0_dep_modules\puppetlabs-stdlib-4.12.0.tar.gz" --ignore-dependencies --modulepath $modulesDir

