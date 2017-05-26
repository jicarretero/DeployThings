# Lanzar Instancias en Openstack

It takes 2 positional arguments, the name of the instance and the number of instances. By default, the instance name is *foonova* and the number of instances is:

	launch_tests.sh [InstanceName [NumberOfInstances]]

This launches a VM in Openstack using some default values for Network, Flavor, etc. Take a look at the begining of the Script and change the values so they fit for your purposes.

This script expects a file named "files/ansible-kp.pub" to be present in order to inject it as a default Key to work with ansible.
