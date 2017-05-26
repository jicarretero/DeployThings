# Deploy and configure a Keystone

This installs a keystone of Liberty version.

# Usage --- This should improve in time.
To install Keystone (Liberty version), you only need to run the command:

	ansible-playbook -i ../../inventory install_mysql.yml

In the inventory file the section **keystone_containers** is expected.

We need for the configuration a file to define de default parameters of the Keystone Installation, 
"default/keystone_defaults.yml"

	admin_token: 134554321
	
	config_file: /etc/keystone/keystone.conf
	
	keystone_dbsync_host: foonova-0
	keystone:
	  host: 192.168.250.206
	  admin_port: 35357
	  service_port: 5000
	  version: v2.0
	  # 2do service_id tengo que convertirlo en fact.
	  # service_id: 4f82df7699f24f3d829849fc60e04924
	  region: SpainTest
	  admin_password: admin1
	
	keystone_config:
	  auth_uri: "http://{{keystone.host}}:{{keystone.service_port}}"
	  auth_url: "http://{{keystone.host}}:{{keystone.admin_port}}"
	  project_domain_id: default
	  user_domain_id: default
	  project_name: service

In order to configure the databases in keystone.conf file, we'll need a "default/databases.yml" file:

	---
	databases:
	  keystone:
	    dbname: keystone
	    user: keystone
	    password: ks12345
	
	database_host: 192.168.250.206


# Configure Keystone
To configure Keystone using the Openstack APIs, you need to run the command:

	ansible-playbook  -i ../../inventory  configure_keystone.yml

To configure keystone we need a file named "default/passwords.yml" where the password, projects, roles, etc are 
defined:

	service_passwords:
	  os_admin:
	    name: admin
	    password: admin1
	    role: admin
	    project: admin
	
	  keystone:
	    name: keystone
	    password: ks12345
	    role: admin
	    project: service
	    service_name: keystone
	    service_type: identity
	    publicurl: http://192.168.250.206:5000/v2.0
	    internalurl: http://192.168.250.206:5000/v2.0
	    adminurl: http://192.168.250.206:35357/v2.0
	
	  glance:
	    name: glance
	    password: gl12345
	    role: admin
	    project: service
	    service_name: glance
	    service_type: image
	    publicurl: http://controller_host:9292/v1
	    internalurl: http://controller_host:9292/v1
	    adminurl: http://controller_host:9292/v1
	
	.....

And another file 
