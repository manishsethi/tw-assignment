name 'mysql'
maintainer 'manishsethi'
maintainer_email 'manish@sethis.in'
license 'Apache 2.0'
description 'Provides mysql_service and mysql_client resources'

version '5.4.3'

supports 'amazon'
supports 'redhat'
supports 'centos'
supports 'fedora'
supports 'debian'
supports 'ubuntu'


depends 'yum-mysql-community'
