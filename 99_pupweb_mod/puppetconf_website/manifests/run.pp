define puppetconf_website::run(
  $website_source = '',
  $dotnetcore_source = '',
  $logoutput = false,
) {

  exec { "dnc_run_${website_source}":
    command   => template('puppetconf_website/dnc-run-command.ps1'),
    unless    => template('puppetconf_website/dnc-run-check.ps1'),
    provider  => powershell,
    logoutput => $logoutput,
  }
}