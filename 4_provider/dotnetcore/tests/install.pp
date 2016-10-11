node default {

  dotnetcore::install { 'default':
    version      => '1.0.1',
    architecture => 'x64',
    sdk          => false,
  }

}
