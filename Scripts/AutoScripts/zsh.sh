#!/data/data/com.termux/files/usr/bin/bash
pkg i -y tur-repo x11-repo
apt update -y&&yes|apt upgrade
pkg i -y zsh
D1="$HOME/.config/pip";F1="$D1/pip.conf"
mkdir -p "$D1"
grep -q termux-user-repository "$F1" 2>/dev/null||cat>>"$F1"<<'EOF'
[install]
extra-index-url = https://termux-user-repository.github.io/pypi/
EOF
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
