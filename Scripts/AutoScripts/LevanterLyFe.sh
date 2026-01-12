
A1=$HOME
A2=$A1/android-ndk
A3=$A2/AndroidNDK
A4=$A1/levanter
clear
echo "Levanter Termux Installer"
sleep 3
tprintf 'n\n' | termux-setup-storage
termux-wake-lock
apt-get update
pkg install -y tur-repo x11-repo
apt-get update
apt update -y && yes | apt upgrade && pkg install -y python nano clang make git ffmpeg nodejs-22 pkg-config libxml2 libxslt rust binutils wget libvips python-pip glib file p7zip
pip install cython wheel setuptools python-dotenv
mkdir -p $A2 $A4 $A1/.gyp
curl -fsSL https://raw.githubusercontent.com/weskerty/MysticTools/refs/heads/main/Utilidades/Lev/.bashrc -o $A1/.bashrc
wget -O $A1/android-ndk.7z https://github.com/lzhiyong/termux-ndk/releases/download/android-ndk/android-ndk-r29-aarch64.7z
7z x $A1/android-ndk.7z -o$A2
rm $A1/android-ndk.7z
mv $A2/android-ndk-* $A3
export ANDROID_NDK_HOME=$A3
export PATH=$ANDROID_NDK_HOME:$PATH
curl -fsSL https://raw.githubusercontent.com/weskerty/MysticTools/refs/heads/main/Utilidades/Lev/include.gypi -o $A1/.gyp/include.gypi
curl -fsSL https://raw.githubusercontent.com/weskerty/MysticTools/refs/heads/main/Utilidades/Lev/lev.sh -o $A1/lev.sh
chmod +x $A1/lev.sh
git clone https://github.com/lyfe00011/levanter.git $A4
curl -fsSL https://raw.githubusercontent.com/weskerty/MysticTools/refs/heads/main/Utilidades/Lev/config.env -o $A4/config.env
npm install -g yarn
yarn global add pm2
cd $A4
yarn install
read -p "SESSION_ID? (y/n): " A5
if [ "$A5" = "y" ]; then
read -p "SESSION_ID: " A6
echo SESSION_ID=$A6 >> $A4/config.env
fi
npm start
