apt-get #!/data/data/com.termux/files/usr/bin/bash
pkg i -y tur-repo x11-repo
apt update -y && yes | apt upgrade && pkg install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
