require Pathname.new(__FILE__).dirname + '../' + 'puppet_x/dotnetcore/dotnetcore_info'

Facter.add('dotnetcore_sdk') do
  confine :osfamily => :windows
  setcode do
    begin
      sdk = nil
      if File.exists?(PuppetX::Dotnetcore::Info.default_exe)
        sdk = Dir.exists?(File.join(PuppetX::Dotnetcore::Info.default_path,'sdk'))
      end
      sdk
    rescue
    end
  end
end
