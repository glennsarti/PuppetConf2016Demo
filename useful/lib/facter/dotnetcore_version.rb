Facter.add('dotnetcore_version') do
  confine :osfamily => :windows
  setcode do
    begin
      dnc_version = Facter::Util::Resolution.exec('dotnet.exe --version')
      #dnc_version = Facter::Util::Resolution.exec('C:/source/puppetconf-2016/temp/base/dnc/dotnet.exe --version')
      dnc_version
    rescue
    end
  end
end
