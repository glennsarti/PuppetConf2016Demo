require 'spec_helper'
require 'facter'
require 'puppet_x/dotnetcore/dotnetcore_info'

describe 'dotnetcore_version fact' do
  subject(:fact) { Facter.fact(:dotnetcore_version) }

  before :each do
    Facter.clear
    Facter.clear_messages
  end

  after :each do
    Facter.clear
    Facter.clear_messages
  end

  context "on Windows", :if => Puppet::Util::Platform.windows? do
    it "should return version if calling an SDK version of dotnetcore" do
      dotnet_version = <<-DNCVER
1.0.0-preview2-003121
DNCVER

      PuppetX::Dotnetcore::Info.expects(:get_version_information).returns(dotnet_version)

      expect(subject.value).to eq("1.0.0-preview2-003121")
    end

    it "should return version if calling an runtime version of dotnetcore" do
      dotnet_version = <<-DNCVER

Microsoft .NET Core Shared Framework Host

  Version  : 1.0.1
  Build    : cee57bf6c981237d80aa1631cfe83cb9ba329f12

Usage: dotnet [common-options] [[options] path-to-application]

Common Options:
  --help                           Display .NET Core Shared Framework Host help.
  --version                        Display .NET Core Shared Framework Host version.

Options:
  --fx-version <version>           Version of the installed Shared Framework to use to run the application.
  --additionalprobingpath <path>   Path containing probing policy and assemblies to probe for.

Path to Application:
  The path to a .NET Core managed application, dll or exe file to execute.

If you are debugging the Shared Framework Host, set 'COREHOST_TRACE' to '1' in your environment.

To get started on developing applications for .NET Core, install .NET SDK from:
  http://go.microsoft.com/fwlink/?LinkID=798306&clcid=0x409

DNCVER

      PuppetX::Dotnetcore::Info.expects(:get_version_information).returns(dotnet_version)

      expect(subject.value).to eq("1.0.1")
    end

    it "should return nil if dotnet is not installed" do
      dotnet_version = nil
      PuppetX::Dotnetcore::Info.expects(:get_version_information).returns(dotnet_version)

      expect(subject.value).to eq(nil)
    end
  end
end
