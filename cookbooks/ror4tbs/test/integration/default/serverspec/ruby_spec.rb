require_relative 'spec_helper'

describe 'ruby' do
  it 'has ruby 2.1.5 installed and set as the default version' do
    cmd = command 'ruby -v'
    expect(cmd.stdout).to match 'ruby 2.1.5'
  end

  describe package('bundler') do
    it { should be_installed.by('gem') }
  end

  describe package('rails') do
    it { should be_installed.by('gem') }
    it 'has Rails 4.2.0 installed' do
      cmd = command 'rails --version'
      expect(cmd.stdout).to match 'Rails 4.2.0'
    end
  end
end
