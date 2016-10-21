node default {

  dotnetcore::install { 'default':
    version      => '1.0.0-preview2-003121',
    architecture => 'x64',
    sdk          => true,

    source       => 'http://puppetconfdemoserver.localdomain/dotnetcore',
    logoutput    => true,
  }

}
