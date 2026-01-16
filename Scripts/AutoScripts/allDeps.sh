A1=$HOME
A2=$A1/android-ndk
A3=$A2/AndroidNDK
A4=$A1/levanter
clear
echo "\e[1;33m⚠️ ACEPTA LOS PERMISOS CUANDO APAREZCAN \e[0m"
echo "\e[1;33m⚠️ CONCEDE PERMISOS DE ALMACENAMIENTO Y EJECUCION \e[0m"
sleep 5
printf 'n\n' | termux-setup-storage
termux-wake-lock
apt-get update
pkg install -y tur-repo x11-repo
apt-get update
apt update -y && yes | apt upgrade && pkg install -y python nano clang make git ffmpeg android-tools clang make git ffmpeg nodejs-lts pkg-config libxml2 libxslt matplotlib xorgproto rust binutils wget build-essential libvips python-pip glib termux-services termux-api termux-x11-nightly p7zip

pip install cython wheel setuptools python-dotenv
mkdir -p $A2 $A1/.gyp


if [ ! -f "$A1/android-ndk.7z" ]; then
    wget -O $A1/android-ndk.7z https://github.com/lzhiyong/termux-ndk/releases/download/android-ndk/android-ndk-r29-aarch64.7z
fi

7z x -aoa $A1/android-ndk.7z -o$A2

# borrar zip 
# rm $A1/android-ndk.7z


mv $A2/android-ndk-* $A3
export ANDROID_NDK_HOME=$A3
export PATH=$ANDROID_NDK_HOME:$PATH

echo "{ \"variables\": { \"android_ndk_path\": \"$ANDROID_NDK_HOME\" } }" > $A1/.gyp/include.gypi

