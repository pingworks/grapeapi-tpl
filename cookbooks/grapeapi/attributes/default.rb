# Mysql DB
default['mysql']['server_root_password'] = 'vagrant'
default['mysql']['server_debian_password'] = 'vagrant'

default['phpmyadmin']['fpm'] = true

# Rails App
# overridden in Vagrantfile
default['grapeapi']['app_basedir'] = '/vagrant'
default['grapeapi']['app_name'] = 'grapeapi'
