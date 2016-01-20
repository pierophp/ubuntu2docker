# Docker no Windows / MAC

## Introdução

Por algumas limitações dentro do boot2docker, foi criado o ubuntu2docker.

Para rodar o docker no Windows / MAC com performance, o segredo é deixar os arquivos dentro do Virtual Box.

Para acessar seus arquivos, é utilizado um compartilhamento NFS.

Como existe a possibilidade da sua VM corromper, é feito um backup da sua /home/docker a cada 10 minutos na sua pasta pessoal no Windows / MAC na pasta "docker_bkp".

## Instalação

Instale:
- <a href="https://www.virtualbox.org/" target="_blank">VirtualBox</a>
- <a href="https://git-scm.com/" target="_blank">Git</a>

## Máquina Virtual
Instale o Ubuntu Server, com um usuário "docker"

### Rede

Criar 2 interfaces de rede:

- NAT

Crie um redirecionamento de porta da porta 2222 para 22.

- Placa de rede exclusiva de hospedeiro (host-only)

## Alteração do IP
Acesse as configurações gerais do Virtual Box, vá em Rede, Redes Exclusivas de Hospedeiro, edite, Servidor DHCP, desmarque a opção Habilitar Servidor.

## Alias para acessar a VM

Abra o Git Bash e adicione isso ao arquivo ~/.bash_profile no WINDOWS ou ~/.profile no MAC
```
alias dssh='ssh -i ~/.docker/machine/machines/default/id_rsa -p 2222 docker@127.0.0.1'
```

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
192.168.99.2 docker.dev
```
## Acessando seus arquivos

No Windows abra um CMD e monte o caminho remoto:
```
net use Z: \\docker.dev\docker
```
No MAC, execute esse comando:
```
mount | grep smbfs && diskutil unmount /Volumes/docker
test -d /Volumes/docker || mkdir /Volumes/docker
mount_smbfs //guest:@docker.dev/docker /Volumes/docker
```

Depois acesse em:
```
/Volumes/docker/
```
