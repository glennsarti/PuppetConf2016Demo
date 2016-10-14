require 'spec_helper'
require 'facter'
require 'puppet_x/dotnetcore/dotnetcore_info'

describe 'dotnetcore_path fact' do
  subject(:fact) { Facter.fact(:dotnetcore_path) }

  before :each do
    Facter.clear
    Facter.clear_messages
  end

  after :each do
    Facter.clear
    Facter.clear_messages
  end

  context "on Windows", :if => Puppet::Util::Platform.windows? do
    it "should return the output of PuppetX::Dotnetcore::Info.default_exe if it exists" do
      expected_value = 'C:\somewhere\dotnet.exe'
      PuppetX::Dotnetcore::Info.expects(:default_exe).returns(expected_value)
      File.expects(:exists?).with(expected_value).returns(true)

      expect(subject.value).to eq(expected_value)
    end

    it "should return nil if PuppetX::Dotnetcore::Info.default_exe does not exist" do
      expected_value = 'C:\somewhere\dotnet.exe'
      PuppetX::Dotnetcore::Info.expects(:default_exe).returns(expected_value)
      File.expects(:exists?).with(expected_value).returns(false)

      expect(subject.value).to eq(nil)
    end
  end
end
