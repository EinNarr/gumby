#!/bin/bash -xe

EXPECTED_ARGS=3
if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: init.sh repository_dir repository_url bridge_ip"
    exit 65
fi
REPOSITORY_DIR="$1"
REPOSITORY_URL="$2"
BRIDGE_IP="$3"

ifconfig eth0 up 
route add default gw $BRIDGE_IP

export PATH=$PATH:/usr/bin

# done by lxc (added them to debootstrap)
# apt-get update
# apt-get install -y lxc subversion make g++ wget
if [ ! -d "/home/libevent-2.0.21-stable" ]; then
	cd /home/
	wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz --no-check-certificate
	tar -xvf libevent-2.0.21-stable.tar.gz
	cd /home/libevent-2.0.21-stable
	./configure && make install
fi 





svn co $REPOSITORY_URL $REPOSITORY_DIR

cd $REPOSITORY_DIR
make




