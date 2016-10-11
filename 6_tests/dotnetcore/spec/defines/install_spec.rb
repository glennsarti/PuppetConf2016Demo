require 'spec_helper'

shared_examples 'validation error' do
  it {
    expect { catalogue }.to raise_error(Puppet::Error)
  }
end

# The naming here can be a bit magical.  puppet_spec_helper adds many helpful functions ....
#   The 'describe' name is the defined type name 
describe 'dotnetcore::install' do

#   The 'title' is the resource name for described resource
#   e.g.  dotnetcore::install { 'default': }
  let(:title) { 'default' }

  context 'on windows' do
#   facts can be mocked using let(:facts)
    let(:facts) { {:osfamily => 'windows', :system32 => 'C:\Windows\System32'} }

    context 'with default values for all parameters' do
      it { should compile }

      it do

#     Note the double underscore instead of double colon '::'
#       'contain_' means the compiled catalog should contain a resource with the following properties.
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

#   The parameters of a resource can be set using let(:params) .. 
#   e.g.  dotnetcore::install { 'default':
#           sdk => ''
#         }
        let(:params) { {:sdk => ''} }

# Shared examples reduce amount of duplication of test code.
# Remember to make them meaningful though
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
