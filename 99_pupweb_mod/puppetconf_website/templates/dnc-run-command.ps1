Write-Verbose "Package Restore"

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

# Also convert linux path seperator to Windows
$dotnetexe = "<%= @dotnetcore_source %>\dotnet.exe".Replace('/','\')
$Website_Source = '<%= @website_source %>'.Replace('/','\')
if ($dotnetexe.StartsWith('\')) { $dotnetexe = $dotnetexe.Substring(1,$dotnetexe.Length - 1) }

Write-Verbose "dotnetexe = $dotnetexe"
Write-Verbose "Website_Source = $"

Set-Location $Website_Source
Write-Verbose "Starting the website..."
$result = Start-Process -FilePath $dotnetexe -ArgumentList 'run' -WorkingDirectory $Website_Source -Wait:$false -PassThru

Write-Verbose $result

Exit 1