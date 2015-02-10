#
# Cookbook Name:: ror4tbs
# Recipe:: _ruby
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

# ruby build deps
package 'libxslt-dev'
package 'libxml2-dev'
package 'build-essential'
package 'libpq-dev'
package 'libsqlite3-dev'

#
# Add apt-add-repository.
#
package 'software-properties-common'

#
# Add brightbox ruby repo.
#
execute 'apt-add-repository ppa:brightbox/ruby-ng -y'

#
# Update dependencies.
#
execute 'apt-get update' do
  ignore_failure true
end

#
# Install Ruby 2.1
#
package 'ruby2.1'
package 'ruby2.1-dev'

#
# Install Bundler, build it against the newly installed 2.1 gem binary
#
gem_package 'bundler' do
  gem_binary('/usr/bin/gem2.1')
end

#
# Install yajl-ruby, required for re-provisioning Chef.
#
gem_package 'yajl-ruby' do
  gem_binary('/usr/bin/gem2.1')
end

#
# Install Rails.
#
#gem_package 'rails' do
#  gem_binary('/usr/bin/gem2.1')
#  version '4.2.0'
#end
