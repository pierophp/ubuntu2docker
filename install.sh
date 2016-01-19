# update
apt-get update

# upgrade SO
apt-get upgrade

# install utils
apt-get install -y openssh-server

# install docker
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker docker

# install NFS
apt-get install -y nfs-kernel-server

# Adicionar /etc/exports
# /export/docker *(rw,insecure,sync,no_subtree_check,fsid=0,no_root_squash)

exportfs -a

# Adicionar /etc/network/interfaces
# allow-hotplug eth1
# iface eth1 inet dhcp

ifconfig eth1 192.168.99.100
