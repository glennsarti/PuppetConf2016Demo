require 'spec_helper'
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..','..', 'lib/puppet_x/dotnetcore/dotnetcore_info.rb'))

describe 'PuppetX::Dotnetcore::Info' do
  let(:subject) { PuppetX::Dotnetcore::Info }

  describe 'default_path' do
    it "should use the windir environment variable" do
      Puppet::Util.expects(:get_env).with('windir').at_least_once.returns('Z:\WINDIR')
      result = subject.default_path

      expect(result).to start_with("Z:/WINDIR")
    end

    it "should end in 'System32/dotnetcore'" do
      Puppet::Util.expects(:get_env).with('windir').at_least_once.returns('Z:\WINDIR')
      result = subject.default_path

      expect(result).to end_with("System32/dotnetcore")
    end
  end


  describe 'default_exe' do
    it "should use default_path" do
      subject.expects(:default_path).at_least_once.returns('Z:/foo')
      result = subject.default_exe

      expect(result).to start_with("Z:/foo")
    end
    
    it "should end in 'dotnet.exe'" do
      subject.expects(:default_path).at_least_once.returns('Z:/foo')
      result = subject.default_exe

      expect(result).to end_with('dotnet.exe')
    end
  end


  describe 'get_runtime_information' do
    before(:each) do
      Puppet::Util::Execution.expects(:execute).never.throws "Should not execute anything on local OS"
    end

    context 'on a Windows platform' do
      before(:each) do
        Puppet::Util::Platform.stubs(:windows?).returns true
      end

      let (:default_path) { 'Z:/foo/dotnet.exe' }
      let (:non_default_path) { 'Z:/this/path/does/not/exist/dotnet.exe' }
      let (:raw_runtime_information) { ".NET Command Line Tools (1.0.0-preview2-003121)\r\n\r\nVersion:            1.0.0-preview2-003121\r\n"}
      let (:runtime_information) { ".NET Command Line Tools (1.0.0-preview2-003121)\n\nVersion:            1.0.0-preview2-003121\n"}

      it "should use the default_exe_path if dotnet_exe_path is not specified" do
        subject.expects(:default_path).at_least_once.returns(default_path)

        Puppet::Util::Execution.expects(:execute).with() { |command| /#{default_path}/.match command }.returns raw_runtime_information

        result = subject.get_runtime_information()
      end

      it "should use the specified dotnet_exe_path" do
        subject.expects(:default_path).never

        Puppet::Util::Execution.expects(:execute).with() { |command| /#{non_default_path}/.match command }.returns raw_runtime_information

        result = subject.get_runtime_information(non_default_path)
      end

      it "should strip carriage return characters" do
        subject.stubs(:default_path).returns(default_path)

        Puppet::Util::Execution.expects(:execute).returns raw_runtime_information

        result = subject.get_runtime_information()
        expect(result).to eq(runtime_information)
      end

      it "should throw if the executable does not exist" do
        subject.expects(:default_path).never

        Puppet::Util::Execution.unstub(:execute)

        expect{subject.get_runtime_information(non_default_path)}.to raise_error(/No such file or directory/)
      end

    end

    context 'on a non-Windows platform' do
      before(:each) do
        Puppet::Util::Platform.stubs(:windows?).returns false
      end

      it "should return nil with default parameters" do
        result = subject.get_runtime_information()

        expect(result).to be(nil)
      end

      it "should return nil with specified parameters" do
        result = subject.get_runtime_information('/etc/foo')

        expect(result).to be(nil)
      end
    end
  end


  describe 'get_version_information' do
    before(:each) do
      Puppet::Util::Execution.expects(:execute).never.throws "Should not execute anything on local OS"
    end

    context 'on a Windows platform' do
      before(:each) do
        Puppet::Util::Platform.stubs(:windows?).returns true
      end

      let (:default_path) { 'Z:/foo/dotnet.exe' }
      let (:non_default_path) { 'Z:/this/path/does/not/exist/dotnet.exe' }
      let (:raw_version_information) { "1.0.0-preview2-003121\r\n"}
      let (:version_information) { "1.0.0-preview2-003121\n"}

      it "should use the default_exe_path if dotnet_exe_path is not specified" do
        subject.expects(:default_path).at_least_once.returns(default_path)

        Puppet::Util::Execution.expects(:execute).with() { |command| /#{default_path}/.match command }.returns raw_version_information

        $result = subject.get_version_information()
      end

      it "should use the specified dotnet_exe_path" do
        subject.expects(:default_path).never

        Puppet::Util::Execution.expects(:execute).with() { |command| /#{non_default_path}/.match command }.returns raw_version_information

        $result = subject.get_version_information(non_default_path)
      end

      it "should strip carriage return characters" do
        subject.stubs(:default_path).returns(default_path)

        Puppet::Util::Execution.expects(:execute).returns raw_version_information

        $result = subject.get_version_information()
        expect($result).to eq(version_information)
      end

      it "should throw if the executable does not exist" do
        subject.expects(:default_path).never

        Puppet::Util::Execution.unstub(:execute)

        expect{subject.get_version_information(non_default_path)}.to raise_error(/No such file or directory/)
      end

    end

    context 'on a non-Windows platform' do
      before(:each) do
        Puppet::Util::Platform.stubs(:windows?).returns false
      end

      it "should return nil with default parameters" do
        $result = subject.get_version_information()

        expect($result).to be(nil)
      end

      it "should return nil with specified parameters" do
        $result = subject.get_version_information('/etc/foo')

        expect($result).to be(nil)
      end
    end
  end

end
