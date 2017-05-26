# Uso:
Para instalar mysql:


Para crear bases de datos, tenemos que definir un fichero con descripción de bases de datos definidas:

	ansible-playbook -i ../../inventory -e databases_file=./default/databases.yml  createdatabases.yml  

## Inventory
The Inventory file is supposed to contain a section **mysql_containers** defining the mysql hosts.

## Install Database Software
To install the database Software:

	ansible-playbook -i ../../inventory install_mysql.yml

A config file is needed named default/password.yml -- The only content needed is:

	---
	mysql_passwords:
	    root_password: root12345 


## Create databases and users
Once the databae Software is installed, we can use some ansible scripts to create databases and users. The same
password file (default/password.yml) which was used to install the database software.

We need a database definition file. As an example, we provide one database.yml file. You'll need to add the 
database file using an environment variable (-e database_file=xxxxxx.yml). This is an example of a database 
definition file:

	---
	databases:
	  keystone:
	    dbname: keystone
	    user: keystone
	    password: ks12345
	
	  glance:
	    dbname: glance
	    user: glance
	    password: gl12345
	
	  nova:
	    dbname: nova
	    user: nova
	    password: nv12345
	
	  neutron:
	    dbname: neutron
	    user: neutron
	    password: nt12345
	
	  cinder:
	    dbname: cinder
	    user: cinder
	    password: cd12345


So, to create all of those databases and add all those users, we can invoke:

	ansible-playbook -i ../../inventory -e databases_file=./default/databases.yml  createdatabases.yml

## Create galera cluster
Experimental yet.
