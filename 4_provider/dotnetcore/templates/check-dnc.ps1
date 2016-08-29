$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

Write-Verbose "Check DNC"

# Also convert linux path seperator to Windows
$DestinationDir = '<%= @destdir %>'.Replace('/','\')
$SDK = ('<%= @sdk%>'.ToUpper() -eq 'TRUE')
$Version = '<%= @version %>'
$Source = ''

Write-Verbose "DestinationDir = $DestinationDir"
Write-Verbose "Version = $Version"
Write-Verbose "SDK = $SDK"
Write-Verbose "Source = $Source"

$dotnetExe = Join-Path -Path $DestinationDir -ChildPath 'dotnet.exe'
$sdkPath = Join-Path -Path $DestinationDir -ChildPath 'sdk'

If (-not (Test-Path -Path $dotnetExe)) { Write-Verbose "dotnet exe does not exist"; Exit 1}
if ($SDK -ne (Test-Path -Path $sdkPath)) { Write-Verbose "sdk is not correct"; Exit 1}

# Run dotnet.exe --version to get information about arch and version
$info_version = ''

$info = & $dotnetExe --version
if ($info -ne $null) { $info = $info -join "`n" }
# Get the version
if ($matches -ne $null) { $matches.Clear() }
if ($info -match '(?smi)^\s*Version\s*:\s*([a-zA-Z0-9\-\.]+)$') {
  $info_version = $matches[1]
}
if ($info -match '(?si)^([a-zA-Z0-9\-\.]+)$') {
  $info_version = $matches[1]
}

if ($info_version -ne $version) { Write-Verbose "version is not correct. Expected $version Found $info_version"; Exit 1}

Exit 0
