# Gravando usuário máquina host
read -p "Qual seu usuário da máquina host?" user
echo $user > /home/docker/user_host
test -d /c/Users && ln -s /c/Users /Users
mkdir /Users/$user/docker_bkp

# update
echo "Atualizando Ubuntu"
apt-get update

# upgrade SO
apt-get upgrade


# install utils
echo "Instalando Ferramentas"
apt-get install -y openssh-server git nano

echo "Instalando Docker"
# install docker
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker docker

#Docker Compose
echo "Instalando Docker Compose"
wget https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` -O /home/docker/docker-compose
mv /home/docker/docker-compose /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install NFS
echo "Instalando NFS"
apt-get install -y nfs-kernel-server
mkdir /export
chmod -R 777 /home/docker
# sgid
chown -R :20 /home/docker
find /home/docker -type d exec chmod g+rwxs {} \;
ln -s /home/docker /export/docker


# Adicionar /etc/exports
echo "/export/docker *(rw,insecure,sync,no_subtree_check,fsid=0,no_root_squash)" >> /etc/exports
exportfs -a

# Adicionar
echo "allow-hotplug eth1" >> /etc/network/interfaces
echo "iface eth1 inet dhcp" >> /etc/network/interfaces

echo "ifconfig eth1 192.168.99.100" > /etc/rc.local

echo "Baixando o container rsync"
docker pull bfosberry/rsync

echo "Reiniciando"
reboot
