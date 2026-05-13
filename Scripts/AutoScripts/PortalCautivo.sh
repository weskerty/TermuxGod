A1=$HOME

clear
echo "\e[1;33m⚠️ ACEPTA LOS PERMISOS CUANDO APAREZCAN \e[0m"
echo "\e[1;33m⚠️ CONCEDE PERMISOS DE EJECUCION \e[0m"
sleep 5

termux-wake-lock 

apt-get update
pkg install -y tur-repo x11-repo
apt-get update
apt update -y && yes | apt upgrade && pkg install -y git nodejs-lts pkg-config wget termux-services termux-api

# PIP TUR
mkdir -p ~/.config/pip
echo -e "[install]\nextra-index-url = https://termux-user-repository.github.io/pypi/" > ~/.config/pip/pip.conf

git clone https://github.com/weskerty/PortalSecuestrao.git ~/portal && cd ~/portal && npm install --force && bash ~/portal/x.sh

