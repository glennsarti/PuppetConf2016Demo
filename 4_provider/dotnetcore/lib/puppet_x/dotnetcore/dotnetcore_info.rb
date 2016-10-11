module PuppetX
  module Dotnetcore
    class Info

      def self.default_path
        def_path = File.join(File.join(Puppet::Util.get_env('windir'),'System32'),'dotnetcore')

        File.expand_path(def_path)
      end

      def self.default_exe
        File.join(self.default_path,'dotnet.exe')
      end

      def self.get_runtime_information(dotnet_exe_path = nil)
        if Puppet::Util::Platform.windows?
          dotnet_exe_path = self.default_exe if dotnet_exe_path.nil?
          Puppet::Util::Execution.execute("#{dotnet_exe_path} --info", :failonfail => false).gsub("\r","")
        end
      end

      def self.get_version_information(dotnet_exe_path = nil)
        if Puppet::Util::Platform.windows?
          dotnet_exe_path = self.default_exe if dotnet_exe_path.nil?
          Puppet::Util::Execution.execute("#{dotnet_exe_path} -version", :failonfail => false).gsub("\r","")
        end
      end

    end
  end
end
