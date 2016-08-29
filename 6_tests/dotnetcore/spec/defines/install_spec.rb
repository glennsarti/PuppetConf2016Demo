require 'spec_helper'

shared_examples 'validation error' do
  it {
    expect { catalogue }.to raise_error(Puppet::Error)
  }
end

describe 'dotnetcore::install' do
  let(:title) { 'default' }

  context 'on windows' do
    let(:facts) { {:osfamily => 'windows', :system32 => 'C:\Windows\System32'} }

    context 'with default values for all parameters' do
      it { should compile }

      # Note the double underscore instead of double colon '::'
      it do
        is_expected.to contain_dotnetcore__install('default').with({
          'architecture' => 'x64',
          'version'  => '1.0.0',
          'sdk'  => false,
        })
      end
    end

    context 'sdk =>' do
      # Unhappy path
      describe 'empty' do
        let(:params) { {:sdk => ''} }
        it_behaves_like 'validation error'
      end
      describe '"foo"' do
        let(:params) { {:sdk => "foo"} }
        it_behaves_like 'validation error'
      end
      # Happy path
      describe 'true' do
        let(:params) { {:sdk => true} }
        it { should compile }
      end
      describe 'false' do
        let(:params) { {:sdk => false} }
        it { should compile }
      end
    end
  end
end
