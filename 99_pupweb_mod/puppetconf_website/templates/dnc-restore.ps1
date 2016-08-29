Write-Verbose "Package Restore"

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

# Also convert linux path seperator to Windows
$dotnetexe = "<%= @dotnetcore_source %>\dotnet.exe"
$DestinationDir = '<%= @destination %>'.Replace('/','\')
if ($dotnetexe.StartsWith('\')) { $dotnetexe = $dotnetexe.Substring(1,$dotnetexe.Length - 1) }

Write-Verbose "Destination = $DestinationDir"

Set-Location $DestinationDir
if (Test-Path -Path "project.lock.json") { Remove-Item -Path 'project.lock.json' -Confirm:$false -Force | Out-Null }

Write-Verbose "Running restore..."
& $dotnetexe restore

Exit $LASTEXITCODE