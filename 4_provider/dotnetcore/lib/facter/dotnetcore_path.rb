require Pathname.new(__FILE__).dirname + '../' + 'puppet_x/dotnetcore/dotnetcore_info'

Facter.add('dotnetcore_path') do
  confine :osfamily => :windows
  setcode do
    begin
      dnc_path = PuppetX::Dotnetcore::Info.default_exe
      File.exists?(dnc_path) ? dnc_path : nil
    rescue
    end
  end
end
