# Docker no Windows / MAC

## Introdução

O boot2docker tem algumas limitações, como:
- O Kernel não vem com suporte a NFS
- Terminal colorido
- Não vem com nano
- É complicado instalar programas

Por isso, foi criado o ubuntu2docker.

Para rodar o docker no Windows / MAC com performance, o segredo é deixar os arquivos dentro do Virtual Box.

Para acessar seus arquivos, é utilizado um compartilhamento NFS.

Como existe a possibilidade da sua VM corromper, é feito um backup da sua /home/docker a cada 10 minutos na sua pasta pessoal no Windows / MAC na pasta "docker_bkp".

## Instalação

Instale:
- <a href="https://www.virtualbox.org/" target="_blank">VirtualBox</a>
- <a href="https://git-scm.com/" target="_blank">Git</a>

## Máquina Virtual

Instale o <a href="http://www.ubuntu.com/server" target="_blank">Ubuntu Server</a>, com um usuário "docker"

## Configurando a Rede

Crie 2 interfaces de rede:

### NAT

Crie um redirecionamento de porta da porta 2222 para a 22.

### Placa de rede exclusiva de hospedeiro (host-only)

Nas Preferências do Virtual Box, na na aba Rede, Redes Exclusivas de Hospedeiro, edite, Servidor DHCP, desmarque a opção Habilitar Servidor.

## Configurando seu ubuntu2docker

Execute esse comando dentro do boot2docker (irá pedir seu usuário do Windows / MAC):
```
sudo wget https://raw.githubusercontent.com/pierophp/ubuntu2docker/master/install.sh -O /install.sh
sudo chmod +x /install.sh
sudo /install.sh
```

## Gerar chave SSH
Gere uma chave SSH e cole no GitHub
```
ssh-keygen -t rsa -b 4096 -C "user@email.com"
cat ~/.ssh/id_rsa.pub
```

No MAC instale o ssh-copy-id (No Windows já vem com o Git Bash)
```
brew install ssh-copy-id
```
No seu Git Bash, Copie a chave para a VM:
```
ssh-copy-id -p 2222 docker@127.0.0.1
```
## Alias para acessar a VM

Abra o Git Bash e adicione isso ao arquivo ~/.bash_profile no WINDOWS ou ~/.profile no MAC
```
alias dssh='ssh -p 2222 docker@127.0.0.1'
```

## Adicionar hostname

Abra o arquivo como administrador no WINDOWS:

```
C:\Windows\System32\Drivers\etc\hosts
```

Abra o arquivo como administrador no MAC:

```
/etc/hosts
```

Adicione seus hosts:
```
192.168.99.100 docker.dev
```
## Acessando seus arquivos

### MAC OS

Execute esse comando:
```
mount | grep nfs && diskutil unmount /Volumes/docker
test -d /Volumes/docker || mkdir /Volumes/docker
mount -t nfs -o proto=tcp,port=2049 docker.dev:/export/docker /Volumes/docker
```

Depois acesse em:
```
/Volumes/docker/
```

### Windows

Instale:
- <a href="https://github.com/dokan-dev/dokany/releases/download/v0.7.4/DokanInstall_0.7.4.exe" target="_blank">Dokany</a>
- <a href="http://www.microsoft.com/download/en/details.aspx?id=17851" target="_blank">Microsoft .NET Framework 4</a>
- <a href="http://nekodrive.googlecode.com/files/NekoDrive_0_9_0.7z" target="_blank">Neko Drive</a>

Abra o Neko Drive, conecte no IP 192.168.99.100.

Marque a opção "Auto" e a "No Cache".

Coloque o groupId como 20

Mapeie na unidade Z:
