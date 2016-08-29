require 'spec_helper'
describe 'puppetconf_website' do
  context 'with default values for all parameters' do
    it { should contain_class('puppetconf_website') }
  end
end
