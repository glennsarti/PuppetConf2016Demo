define puppetconf_website::install(
  $destination = '',
  $dotnetcore_source = '',
  $logoutput = false,
) {

  # Parent directory
  file { $destination:
    ensure => directory,
  } ->

  # Website files
  file {"${destination}/Program.cs":
    source => "puppet:///modules/puppetconf_website/Program.cs",
  } ->
  file {"${destination}/Startup.cs":
    source => "puppet:///modules/puppetconf_website/Startup.cs",
  } ->
  file {"${destination}/project.json":
    source => "puppet:///modules/puppetconf_website/project.json",
  }

  # Package Restore
  exec { "dnc_restore_${destination}":
    command   => template('puppetconf_website/dnc-restore.ps1'),
    provider  => powershell,
    logoutput => $logoutput,
    refreshonly => true,
    subscribe => File["${destination}/project.json"],
  }
}