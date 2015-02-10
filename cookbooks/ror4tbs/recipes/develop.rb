#
# Cookbook Name:: ror4tbs
# Recipe:: develop
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
include_recipe 'apt'

include_recipe 'ror4tbs::_base'
include_recipe 'ror4tbs::_mysql'
include_recipe 'ror4tbs::_node'
include_recipe 'ror4tbs::_phpmyadmin'
include_recipe 'ror4tbs::_ruby'
include_recipe 'ror4tbs::_rails'


# currently not used
#include_recipe 'ror4tbs::_bower' # also installs nodejs


