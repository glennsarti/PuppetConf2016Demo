define dotnetcore::install(
  $destination = '',
  $architecture = 'x64',
  $version = '1.0.0',
  $sdk = false,
  $logoutput = false,
  $source = '',
  ) {

  # validate_bool($sdk)

  if ($destination == '') {
    $destdir = "${::system32}/dotnetcore"
  }
  else {
    $destdir = $destination
  }

  exec { "dot_net_core_install_$destdir":
    command   => template('dotnetcore/install-dnc.ps1'),
    unless    => template('dotnetcore/check-dnc.ps1'),
    provider  => powershell,
    logoutput => $logoutput,
  }
}