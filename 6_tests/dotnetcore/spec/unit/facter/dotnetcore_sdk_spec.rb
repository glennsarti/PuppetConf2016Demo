require 'spec_helper'
require 'facter'
require 'puppet_x/dotnetcore/dotnetcore_info'

describe 'dotnetcore_sdk fact' do
  subject(:fact) { Facter.fact(:dotnetcore_sdk) }

  before :each do
    Facter.clear
    Facter.clear_messages
  end

  after :each do
    Facter.clear
    Facter.clear_messages
  end

  context "on Windows", :if => Puppet::Util::Platform.windows? do
    it "should return true if PuppetX::Dotnetcore::Info.default_exe exists and has an sdk directory" do
      mock_default_exe = 'C:\somewhere\dotnet.exe'
      mock_default_path = 'C:\somewhere'
      PuppetX::Dotnetcore::Info.expects(:default_exe).returns(mock_default_exe)
      PuppetX::Dotnetcore::Info.expects(:default_path).returns(mock_default_path)
      File.expects(:exists?).with(mock_default_exe).returns(true)
      Dir.expects(:exists?).with("#{mock_default_path}/sdk").returns(true)

      expect(subject.value).to eq(true)
    end

    it "should return false if PuppetX::Dotnetcore::Info.default_exe exists and with no sdk directory" do
      mock_default_exe = 'C:\somewhere\dotnet.exe'
      mock_default_path = 'C:\somewhere'
      PuppetX::Dotnetcore::Info.expects(:default_exe).returns(mock_default_exe)
      PuppetX::Dotnetcore::Info.expects(:default_path).returns(mock_default_path)
      File.expects(:exists?).with(mock_default_exe).returns(true)
      Dir.expects(:exists?).with("#{mock_default_path}/sdk").returns(false)

      expect(subject.value).to eq(false)
    end

    it "should return nil if PuppetX::Dotnetcore::Info.default_exe does not exist" do
      mock_default_exe = 'C:\somewhere\dotnet.exe'
      PuppetX::Dotnetcore::Info.expects(:default_exe).returns(mock_default_exe)
      File.expects(:exists?).with(mock_default_exe).returns(false)

      expect(subject.value).to eq(nil)
    end
  end
end
