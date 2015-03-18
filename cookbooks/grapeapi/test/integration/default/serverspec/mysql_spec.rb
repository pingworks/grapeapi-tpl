require_relative 'spec_helper'

describe 'mysql' do
  it 'is running' do
    expect(process 'mysqld').to be_running
  end

  it 'listens on a tcp socket' do
    expect(port 3306).to be_listening
  end

  #it 'has a vagrant user' do
  #  cmd = command 'echo "\dg" | sudo -u postgres psql'
  #  expect(cmd.stdout).to match 'vagrant'
  #end
end

describe 'phpmyadmin' do
  it 'is running' do
    expect(port 80).to be_listening
  end
end
