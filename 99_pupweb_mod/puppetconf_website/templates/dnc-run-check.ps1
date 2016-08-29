Write-Verbose "Package Restore"

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

# Also convert linux path seperator to Windows
$dotnetexe = "<%= @dotnetcore_source %>\dotnet.exe".Replace('/','\')
$Website_Source = '<%= @website_source %>'.Replace('/','\')

$dotnetexe = 'C:\puppetconf_dnc\dotnetcore\dotnet.exe'
if ($dotnetexe.StartsWith('\')) { $dotnetexe = $dotnetexe.Substring(1,$dotnetexe.Length - 1) }

$runningProc = Get-Process dotnet -ErrorAction SilentlyContinue | ? { $_.Path.ToUpper() -eq $dotnetexe.ToUpper() }

if ($runningProc -eq $null) {
  Write-Verbose "Could not find a running process"
  Exit 0
} else {
  Write-Verbose "Found a running process"
  $runningProc | % { Write-Verbose "Process ID = $($_.Id)" }
  Exit 1
}
