require Pathname.new(__FILE__).dirname + '../' + 'puppet_x/dotnetcore/dotnetcore_info'

Facter.add('dotnetcore_version') do
  confine :osfamily => :windows
  setcode do
    begin
      version = nil
      info = PuppetX::Dotnetcore::Info.get_version_information

      if match = info.match(/^\s*Version\s*:\s*([a-zA-Z0-9\-\.]+)$/m)
        version = match[1]
      end
      if match = info.match(/^([a-zA-Z0-9\-\.]+)$/)
        version = match[1]
      end
      version
    rescue
    end
  end
end
