dotnetcore::install { 'default':
  architecture => 'x64',

  #version => '1.0.1',
  #sdk => false,

  version => '1.0.0-preview2-003121',
  sdk => true,

  logoutput => true,
  source => 'http://puppetconfdemoserver.localdomain/dotnetcore',
}