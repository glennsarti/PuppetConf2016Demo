Puppet::Type.type(:dotnetcore_install).provide(:dotnetcore_windows) do
  include Puppet::Util::Execution

  defaultfor :operatingsystem => :windows
  confine    :operatingsystem => :windows

  #mk_resource_methods

  def self.instances
    []
  end

  # Properties
  def version
    get_dotnetcore_version(dest_dotnet)
  end
  def version=(value)
    install_dotnetcore
  end

  def sdk
    sdk_dir = File.join(dest_dir,'sdk')
    Dir.exists?(sdk_dir)
  end
  def sdk=(value)
    install_dotnetcore
  end

  def architecture
    # https://docs.microsoft.com/en-us/dotnet/articles/core/rid-catalog
    output = get_dotnetcore_info(dest_dotnet)
    nil if output.nil?
 
    if match = output.match(/^\s*RID:\s*([a-zA-Z0-9\-]+)$/m)
      rid = match[1]

      'x86' if rid.end_with?('-x86')
      'x64' if rid.end_with?('-x64')
    end
  end
  def architecture=(value)
    install_dotnetcore
  end

  def exists?
    File.exist?(dest_dotnet)
  end

  def create
    install_dotnetcore
  end

  def destroy
    dest_dir = File.expand_path(resource[:destination])
    # Delete the dest dir if it exists
    FileUtils.rm_rf(dest_dir) if Dir.exists?(dest_dir)
  end

  private
  def dest_dir
    File.expand_path(resource[:destination])
  end

  def dest_dotnet
    File.join(dest_dir,'dotnet.exe')
  end

  def get_dotnetcore_version(exe_path)
    File.exist?(dest_dotnet) ? execute("#{exe_path} --version").chomp : nil
  end

  def get_dotnetcore_info(exe_path)
    File.exist?(dest_dotnet) ? execute("#{exe_path} --info") : nil
  end

  def download_file(url, dest)
    require 'open-uri'

    open(url) do |u|
      File.open(dest, 'wb') { |f| f.write(u.read) }
    end
  end

  def install_dotnetcore
    fail "version cannot be empty" if resource[:version].nil?
    fail "destination cannot be empty" if resource[:destination].nil?

    use_sdk = resource[:sdk]
    version = resource[:version]
    arch = resource[:architecture]
    dest_dir = File.expand_path(resource[:destination])
fail "#{dest_dir} sdk=#{use_sdk} version=#{version} arch=#{arch}"

    url = case
      # with SDK
      when use_sdk && (version == '1.0.0-preview2') && (arch == :x64)
        'https://go.microsoft.com/fwlink/?LinkID=809126'
      when use_sdk && (version == '1.0.0-preview2') && (arch == :x86)
        'https://go.microsoft.com/fwlink/?LinkID=809127'
      # Without SDK
      when !use_sdk && (version == '1.0.1') && (arch == :x64)
        'https://go.microsoft.com/fwlink/?LinkID=825882'
      when !use_sdk && (version == '1.0.1') && (arch == :x86)
        'https://go.microsoft.com/fwlink/?LinkID=825883'
      else
        fail "Unable to determine download URL using version #{version}-#{arch} and using sdk:#{sdk}"
    end

    # Delete the dest dir if it exists
    FileUtils.rm_rf(dest_dir) if Dir.exists?(dest_dir)

    # Download the file to a temporary file
    temp_file = Tempfile.new('dnc_install')
    begin
      download_file(url,temp_file)
      temp_file.close
      
      # Now to extract it
      #  Convert paths to Windows native
      temp_file_win = temp_file.path.gsub('/', '\\')
      dest_dir_win = dest_dir.gsub('/', '\\')
      command = "powershell -NoProfile -NonInteractive -NoLogo -ExecutionPolicy Bypass -Command \"" + 
                "Add-Type -AssemblyName System.IO.Compression.FileSystem;" + 
                "[System.IO.Compression.ZipFile]::ExtractToDirectory('#{temp_file_win}','#{dest_dir_win}')" +
                "\""
      output = Puppet::Util::Execution.execute(command)
    ensure
      temp_file.close
      temp_file.unlink   # deletes the temp file
    end
  end
end
