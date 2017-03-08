haproxy Cookbook
================
Installs haproxy and prepares the configuration location.


Requirements
------------
### Platforms
- Ubuntu (10.04+ due to config option change)
- Redhat (6.0+)
- Debian (6.0+)


Attributes
----------
- `node['haproxy']['incoming_address']` - sets the address to bind the haproxy process on, 0.0.0.0 (all addresses) by default
- `node['haproxy']['incoming_port']` - sets the port on which haproxy listens
- `node['haproxy']['members']` - used by the default recipe to specify the member systems to add. Default


- `node['haproxy']['member_port']` - the port that member systems will
  be listening on if not otherwise specified in the members attribute, default 8080
- `node['haproxy']['member_weight']` - the weight to apply to member systems if not otherwise specified in the members attribute, default 1
- `node['haproxy']['app_server_role']` - used by the `app_lb` recipe to search for a specific role of member systems. Default `webserver`.
- `node['haproxy']['balance_algorithm']` - sets the load balancing algorithm; defaults to roundrobin.
- `node['haproxy']['enable_ssl']` - whether or not to create listeners for ssl, default false
- `node['haproxy']['ssl_incoming_address']` - sets the address to bind the haproxy on for SSL, 0.0.0.0 (all addresses) by default
- `node['haproxy']['ssl_member_port']` - the port that member systems will be listening on for ssl, default 8443
- `node['haproxy']['ssl_incoming_port']` - sets the port on which haproxy listens for ssl, default 443
- `node['haproxy']['httpchk']` - used by the `app_lb` recipe. If set, will configure httpchk in haproxy.conf
- `node['haproxy']['ssl_httpchk']` - used by the `app_lb` recipe. If set and `enable_ssl` is true, will configure httpchk in haproxy.conf for the `ssl_application` section
- `node['haproxy']['enable_admin']` - whether to enable the admin interface. default true. Listens on port 22002.
- `node['haproxy']['admin']['address_bind']` - sets the address to bind the administrative interface on, 127.0.0.1 by default
- `node['haproxy']['admin']['port']` - sets the port for the administrative interface, 22002 by default
- `node['haproxy']['admin']['options']` - sets extras config parameters on the administrative interface, 'stats uri /' by default
- `node['haproxy']['enable_stats_socket']` - controls haproxy socket creation, false by default
- `node['haproxy']['stats_socket_path']` - location of haproxy socket, "/var/run/haproxy.sock" by default
- `node['haproxy']['stats_socket_user']` - user for haproxy socket, default is node['haproxy']['user']
- `node['haproxy']['stats_socket_group']` - group for haproxy socket, default is node['haproxy']['group']
- `node['haproxy']['pid_file']` - the PID file of the haproxy process, used in the tuning recipe.
- `node['haproxy']['global_options']` - global options, like tuning. Format must be of `{ 'option' => 'value' }`; defaults to `{}`.
- `node['haproxy']['defaults_options']` - an array of options to use for the config file's `defaults` stanza, default is ["httplog", "dontlognull", "redispatch"]
- `node['haproxy']['defaults_timeouts']['connect']` - connect timeout in defaults stanza
- `node['haproxy']['defaults_timeouts']['client']` - client timeout in defaults stanza
- `node['haproxy']['defaults_timeouts']['server']` - server timeout in defaults stanza
- `node['haproxy']['x_forwarded_for']` - if true, creates an X-Forwarded-For header containing the original client's IP address. This option disables KeepAlive.
- `node['haproxy']['member_max_connections']` - the maxconn value to be set for each app server
- `node['haproxy']['cookie']` - if set, use this to pin connection to the same server with a cookie.
- `node['haproxy']['user']` - user that haproxy runs as
- `node['haproxy']['group']` - group that haproxy runs as
- `node['haproxy']['global_max_connections']` - in the `app_lb` config, set the global maxconn
- `node['haproxy']['member_max_connections']` - the maxconn value to
  be set for each app server if not otherwise specified in the members attribute
- `node['haproxy']['frontend_max_connections']` - in the `app_lb` config, set the the maxconn per frontend member
- `node['haproxy']['frontend_ssl_max_connections']` - in the `app_lb` config, set the maxconn per frontend member using SSL
- `node['haproxy']['install_method']` - determines which method is used to install haproxy, must be 'source' or 'package'. defaults to 'package'
- `node['haproxy']['conf_dir']` - the location of the haproxy config file
- `node['haproxy']['source']['version']` - the version of haproxy to install
- `node['haproxy']['source']['url']` - the full URL to the haproxy source package
- `node['haproxy']['source']['checksum']` - the checksum of the haproxy source package
- `node['haproxy']['source']['prefix']` - the prefix used to `make install` haproxy
- `node['haproxy']['source']['target_os']` - the target used to `make` haproxy
- `node['haproxy']['source']['target_cpu']` - the target cpu used to `make` haproxy
- `node['haproxy']['source']['target_arch']` - the target arch used to `make` haproxy
- `node['haproxy']['source']['use_pcre']` - whether to build with libpcre support
- `node['haproxy']['package']['version'] `- the version of haproxy to install, default latest
