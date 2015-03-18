#
# Cookbook Name:: grapeapi
# Recipe:: _rails
#
# Copyright 2015 pingworks - Alexander Birk und Christoph Lukas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

directory node['grapeapi']['app_basedir'] do
  user 'vagrant'
  group 'vagrant'
  mode '755'
  action :create
end

cookbook_file 'Gemfile_grape' do
  user 'vagrant'
  group 'vagrant'
  mode '644'
  path "#{node['grapeapi']['app_basedir']}/Gemfile"
end

#cookbook_file 'Gemfile.lock_grape' do
#  user 'vagrant'
#  group 'vagrant'
#  mode '644'
#  path "#{node['grapeapi']['app_basedir']}/Gemfile.lock"
#end

bash 'run bundle install' do
  user 'root'
  code <<-EOF
    cd #{node['grapeapi']['app_basedir']}
    bundle install
  EOF
end

bash 'create new grape app' do
  user 'vagrant'
  code <<-EOF
    cd #{node['grapeapi']['app_basedir']}
    rails new #{node['grapeapi']['app_name']}_app -d mysql
  EOF
  not_if "[ -d  #{node['grapeapi']['app_basedir']}/#{node['grapeapi']['app_name']}_app ]"
end

cookbook_file 'Gemfile_grape' do
  user 'vagrant'
  group 'vagrant'
  mode '644'
  path "#{node['grapeapi']['app_basedir']}/#{node['grapeapi']['app_name']}_app/Gemfile"
end

cookbook_file 'Gemfile.lock_rails' do
  user 'vagrant'
  group 'vagrant'
  mode '644'
  path "#{node['grapeapi']['app_basedir']}/#{node['grapeapi']['app_name']}_app/Gemfile.lock"
end

cookbook_file 'Gemfile_rails' do
  path "#{node['grapeapi']['app_basedir']}/Gemfile"
  action :delete
end

cookbook_file 'Gemfile.lock_rails' do
  path "#{node['grapeapi']['app_basedir']}/Gemfile.lock"
  action :delete
end

bash 'setup mysql db for the new grape app' do
  user 'vagrant'
  code <<-EOF
    cd #{node['grapeapi']['app_basedir']}/#{node['grapeapi']['app_name']}_app
    rake db:create
    rake db:migrate
  EOF
  not_if "echo 'show databases;' | mysql -u root | grep grapeapi-test_app"
end



