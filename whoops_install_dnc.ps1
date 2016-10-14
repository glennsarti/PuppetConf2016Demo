$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

Write-Verbose "Install DNC"
$success = $false

# Also convert linux path seperator to Windows
$DestinationDir = 'C:\windows\system32\dotnetcore'.Replace('/','\')
$SDK = ('true'.ToUpper() -eq 'TRUE')
$Arch = 'x64'
$Version = '1.0.0-preview2-003121'
$Source = 'http://puppetconfdemoserver.localdomain/dotnetcore'

Write-Verbose "DestinationDir = $DestinationDir"
Write-Verbose "Arch = $Arch"
Write-Verbose "Version = $Version"
Write-Verbose "SDK = $SDK"
Write-Verbose "Source = $Source"

Function Get-MicrosoftURL() {
  $url = $null
  '"sdk","version",              "arch","url"' + "`n" +
  '"yes","1.0.0-preview2-003121","x64", "https://go.microsoft.com/fwlink/?LinkID=809126"' + "`n" +
  '"yes","1.0.0-preview2-003121","x86", "https://go.microsoft.com/fwlink/?LinkID=809127"' + "`n" +
  '"no", "1.0.1",                "x64", "https://go.microsoft.com/fwlink/?LinkID=825882"' + "`n" +
  '"no", "1.0.1",                "x86", "https://go.microsoft.com/fwlink/?LinkID=825883"' |
  ConvertFrom-Csv | % {
    if ( ($_.arch -eq $Arch) -and
         ($_.version -eq $Version) -and
         ( ($_.sdk -eq 'yes') -eq $SDK)
    ) { $url = $_.url }
  }
  return $url
}

Function Get-LocalURL() {
  $url = $Source + '/dotnet'
  if ($SDK) { $url += '-dev'}
  $url += "-win-$($Arch).$($Version).zip"

  Write-Output $url
}

try {
  # Init
  $DownloadURL = ''
  If ($Source -ne '') {
    [string]$DownloadURL = Get-LocalURL
  } else {
    [string]$DownloadURL = Get-MicrosoftURL
  }
  if ($DownloadURL -eq '') { Throw "Unable to determine a download location for the specified settings"; Exit 2 }

  if (Test-Path -Path $DestinationDir) {
    Write-Verbose "Clearing out $DestinationDir ..."
    Remove-Item -Path $DestinationDir -Force -Recurse -Confirm:$false | Out-Null
  }

  # Download the zip locally
  ## DANGER - Major hack
  Add-type @"
      using System.Net;
      using System.Security.Cryptography.X509Certificates;
      public class IDontCarePolicy : ICertificatePolicy {
          public IDontCarePolicy() {}
          public bool CheckValidationResult(
              ServicePoint sPoint, X509Certificate cert,
              WebRequest wRequest, int certProb) {
              return true;
          }
      }
"@
  [System.Net.ServicePointManager]::CertificatePolicy = new-object IDontCarePolicy

  $temp_filename = [System.IO.Path]::GetTempFileName()
  try {
    Write-Verbose "Attempting to download the archive from $DownloadURL ..."
    (New-Object System.Net.WebClient).DownloadFile($DownloadURL, $temp_filename) | Out-Null

    if (-not (Test-Path -Path $temp_filename)) { Throw "Failed to download archive"}

    Write-Verbose "Expanding the installation archive ..."
    
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($temp_filename, $DestinationDir)

    Write-Verbose "Completed."
  }
  finally {
    if (Test-Path -Path $temp_filename) { Remove-Item -Path $temp_filename -Force -Confirm:$false | Out-Null }
  }

  $success = $true
} catch {
  Write-Verbose $_
}

if (-not $success) {
  Exit 1
}
Exit 0
