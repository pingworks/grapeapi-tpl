#
# Cookbook Name:: grapeapi
# Recipe:: _phpmyadmin
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

cookbook_file "phpmyadmin.preseed" do
  path "/tmp/phpmyadmin.preseed"
  mode "0644"
  owner "root"
  group "root"
end

bash "manually install phpmyadmin and dependencies" do
  user "root"
  cwd "/root"
  code <<-'EOF'
  export DEBIAN_FRONTEND=noninteractive
  cat /tmp/phpmyadmin.preseed | debconf-set-selections
  apt-get -q -y install phpmyadmin
  php5enmod mcrypt
  service apache2 restart
  sed -i -e 's;// \(.cfg..Servers....i...AllowNoPassword..\);\1;' /etc/phpmyadmin/config.inc.php
  EOF
  not_if "dpkg -l phpmyadmin", :user => 'root'
end
