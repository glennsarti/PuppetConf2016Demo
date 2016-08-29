require 'puppet'

Puppet::Type::newtype(:dotnetcore_install) do

  ensurable

  #newparam(:name, :namevar => true) do
  #  munge do |value|
  #    value.upcase
  #  end
  #end

  newparam(:destination, :namevar => true) do
    desc 'Destination path to install Dot Net Core to.  Defaults to <SYSTEM32>\dotnetcore'

    defaultto File.expand_path(File.join(Facter.value(:system32), 'dotnetcore'))
  end

  newproperty(:version) do
    desc 'Version of Dot Net Core to install'
  end

  newproperty(:architecture) do
    desc 'What architecture of Dot Net core to install. x86 or x64'
    defaultto :x64
    newvalues(:x86, :x64)
  end

  newproperty(:sdk, :boolean => true) do
    defaultto 'false'
    desc 'Whether to install the SDK in the Dot Net core installation'
  end
end
