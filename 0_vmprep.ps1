Set-ExecutionPolicy Bypass -Force -Confirm:$false

$hostsfile = 'C:\Windows\System32\drivers\etc\hosts'

$content = (Get-Content $hostsfile) -join "`n`r"
if ($content -notlike '*puppetconfdemoserver*') {
  Write-Host "Adding puppetconfdemoserver.localdomain to hosts ..."
  "`n192.168.200.199 puppetconfdemoserver puppetconfdemoserver.localdomain" | Out-File $hostsfile -Append -NoClobber -Encoding UTF8
}
if ($content -notlike '*github*') {
  Write-Host "Adding github.com to hosts ..."
  "`n192.30.253.112 github.com www.github.com" | Out-File $hostsfile -Append -NoClobber -Encoding UTF8
}

& gem sources --add http://puppetconfdemoserver.localdomain:8808

Write-Host "Setting GEM_SOURCE"
& reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v GEM_SOURCE /t REG_SZ /d "http://puppetconfdemoserver.localdomain:8808" /f

Write-Host "Setting PATH"
& reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_SZ /d "$($PSScriptRoot);$($ENV:Path)" /f

Write-Host "Requires Reboot"
