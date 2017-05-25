#!/bin/bash -x

dirname=`dirname $0`
cd $dirname


IMAGE=base_ubuntu_14.04
NETUUID=$(openstack network list| awk '/ node-int-net-01 / {print $2}')
FLAVOR=m1.small
KEY=krtkp
SECGROUP=insecure

BASE_NAME=${1:-foonova}
USER_DATA=/tmp/add_ansible.init


declare -a nodes

poll=""

for i in 0 ; do
   [ $i -eq 1 ] && poll="--poll"
   NAME=${BASE_NAME}-${i}

   cat << EOT > $USER_DATA
#!/bin/bash

sudo apt-get -y update

cat << FOO > /etc/ssh/sshd_config
$(cat files/sshd_config)
FOO

cat << FOO > /root/.ssh/authorized_keys
$(cat files/ansible-kp.pub)
FOO

chmod 600 /etc/ssh/sshd_config
echo "127.1.1.1 ${NAME}" >> /etc/hosts
service ssh restart

EOT

   nodes[$i]=$(openstack server create \
       --security-group ${SECGROUP} \
       --key-name ${KEY} \
       --flavor ${FLAVOR} \
       --image ${IMAGE} \
       --nic net-id=$NETUUID \
       --user-data $USER_DATA \
       ${NAME} | awk '/ id / {print $4}') 

done

openstack server list

cd -
