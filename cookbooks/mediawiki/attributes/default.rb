#
# Cookbook Name:: mediawiki
# Attribute:: default
#
# Copyright (C) 2014 Patrick Moore
#
# All rights reserved - Do Not Redistribute
#

default['mediawiki']['enable_https'] = false
default['mediawiki']['version'] = '1.24.0'
default['mediawiki']['path'] = '/var/www/html/wiki'
default['mediawiki']['mysql_host'] = '##.##.##.##'
default['mediawiki']['mysql_password'] = 'somepassword'
default['mediawiki']['mysql_dbname'] = 'wiki'
default['mediawiki']['mysql_dbuser'] = 'wiki_user'
default['mediawiki']['mysql_dbpass'] = 'wiki_pass'
