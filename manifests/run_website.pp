$targetdir = 'C:/puppetconf_dnc'

file { $targetdir:
  ensure => directory,
} ->

dotnetcore::install { 'puppetconf':
  destination  => "${targetdir}/dotnetcore",
  source       => 'http://puppetconfdemoserver.localdomain/dotnetcore',
  architecture => 'x64',
  version      => '1.0.0-preview2-003121',
  sdk          => true,
} ->

puppetconf_website::install { 'puppetconf':
  destination       => "${targetdir}/website",
  dotnetcore_source => "${targetdir}/dotnetcore",
} ->

puppetconf_website::run { 'puppetconf':
  website_source    => "${targetdir}/website",
  dotnetcore_source => "${targetdir}/dotnetcore",
}
