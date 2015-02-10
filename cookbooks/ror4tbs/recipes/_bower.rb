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
package 'nodejs'

bash 'symlink nodejs' do
  user 'root'
  code <<-EOF
    ln -s /usr/bin/nodejs /usr/bin/node
  EOF
  not_if "[ -L /usr/bin/node ]", :user => 'root'

end

package 'npm'

bash 'install bower' do
  user 'root'
  code <<-EOF
    npm -g install bower
  EOF
end

