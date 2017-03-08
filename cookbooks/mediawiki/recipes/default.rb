#
# Cookbook Name:: mediawiki
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'apache2::default'
include_recipe 'apache2::mod_php5'

if node['mediawiki']['enable_https'] == true
  include_recipe 'apache2::mod_ssl'
end

include_recipe 'php::module_mysql'

package 'php-xml'
