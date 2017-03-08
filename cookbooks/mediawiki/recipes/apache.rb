#
# Cookbook Name:: mediawiki
# Recipe:: apache
#
# Copyright (C) 2014 Patrick Moore <moore267@marshall.edu>
#
# All rights reserved - Do Not Redistribute
#

# Set some Apache defaults
node.default['apache']['listen_ports'] = [80]
node.default['apache']['default_site_enabled'] = false

# Create the apache site
web_app 'mediawiki' do
  server_name 'wiki.thoughtworks.in'
  server_aliases ['wiki', 'wiki.thoughtworks.in']
  docroot node['mediawiki']['path']
  template 'wiki.conf.erb'
end
