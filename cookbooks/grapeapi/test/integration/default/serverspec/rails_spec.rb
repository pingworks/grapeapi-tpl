require_relative 'spec_helper'

describe 'rails app '+$node['grapeapi']['app_name'] do
  describe file($node['grapeapi']['app_basedir']+"/"+$node['grapeapi']['app_name']+"_app") do
    it {should be_directory}
  end

  describe 'rails apps database' do
    it 'should be created' do
      cmd = command "echo 'show databases;' | mysql -u root"
      expect(cmd.stdout).to match $node['grapeapi']['app_name']+"_app_development"
      expect(cmd.stdout).to match $node['grapeapi']['app_name']+"_app_test"
    end
  end
end
