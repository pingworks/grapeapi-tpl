#
# Cookbook Name:: ror4tbs
# Recipe:: _base
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

%w(less vim git curl tree).each do |p|
  package p do
    action :install
  end
end

bash "set_editor_vim_root" do
  user "root"
  cwd "/root"
  code <<-EOF
  echo "export EDITOR=vi" >> .bashrc
  EOF
  not_if "grep 'EDITOR=vi' /root/.bashrc", :user => 'root'
end

bash "set_editor_vim_vagrant" do
  user "vagrant"
  cwd "/home/vagrant"
  code <<-EOF
  echo "export EDITOR=vi" >> .bashrc
  EOF
  not_if "grep 'EDITOR=vi' /home/vagrant/.bashrc", :user => 'vagrant'
end

# enable apt-get installs without --force-yes
cookbook_file "11auto" do
  path "/etc/apt/apt.conf.d/11auto"
  mode "0644"
  owner "root"
  group "root"
end
