$ErrorActionPreference = 'Stop'
$srcDir = $PSScriptRoot
$modulesDir = "C:\modules"

# Write-Host 
# & git clone "http://puppetconfdemoserver.localdomain:9000/puppetlabs-powershell.git" "$modulesDir\powershell"
# Push-Location "$modulesDir\powershell"
# & git checkout 2.0.2
# & git reset --hard 2.0.2
# Pop-Location

# & git clone "http://puppetconfdemoserver.localdomain:9000/puppetlabs-stdlib.git" "$modulesDir\stdlib"
# Push-Location "$modulesDir\stdlib"
# & git checkout 4.12.0
# & git reset --hard 4.12.0
# Pop-Location

Write-Host "puppet module install `"$srcDir\local_forge\puppetlabs-powershell-2.0.4.tar.gz`" --ignore-dependencies --modulepath $modulesDir" -ForegroundColor Green
& puppet module install "$srcDir\local_forge\puppetlabs-powershell-2.0.4.tar.gz" --ignore-dependencies --modulepath $modulesDir
#& puppet module install "$srcDir\local_forge\puppetlabs-powershell-2.0.2.tar.gz" --ignore-dependencies --modulepath $modulesDir

Write-Host "puppet module install `"$srcDir\local_forge\puppetlabs-stdlib-4.12.0.tar.gz`" --ignore-dependencies --modulepath $modulesDir" -ForegroundColor Green
& puppet module install "$srcDir\local_forge\puppetlabs-stdlib-4.12.0.tar.gz" --ignore-dependencies --modulepath $modulesDir
