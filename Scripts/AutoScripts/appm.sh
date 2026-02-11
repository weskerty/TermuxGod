#!/data/data/com.termux/files/usr/bin/bash

clear
T="👉✅ Concede los Permisos"
T1="ACCEPT PERMISSIONS WHEN PROMPTED"

printf "\033[33m%s\033[0m \033[31m%s\033[0m\n" "$T1" "$T"
sleep 1
clear
printf "\033[31m%s\033[0m \033[33m%s\033[0m\n" "$T1" "$T"
sleep 1
clear
printf "\033[33m%s\033[0m \033[31m%s\033[0m\n" "$T1" "$T"
sleep 1
clear
printf "\033[31m%s\033[0m \033[33m%s\033[0m\n" "$T1" "$T"

sleep 2

termux-wake-lock

if ! command -v adb >/dev/null 2>&1; then
    printf '\033[33mInstall ADB...\033[0m\n'
    apt update -y
    apt upgrade -y
    pkg install -y android-tools
fi


T2="Pair in ADB Wireless Config on Split Screen"
printf "\033[33m%s\033[0m" "$T2"
sleep 1
printf "\r\033[31m%s\033[0m" "$T2"
sleep 1
printf "\r\033[33m%s\033[0m\n" "$T2"

sleep 3

am start -a android.settings.APPLICATION_DEVELOPMENT_SETTINGS >/dev/null 2>&1
am start -a android.settings.WIRELESS_DEBUGGING_SETTINGS >/dev/null 2>&1


while :; do
    printf '\033[33mPORT_PAIR:\033[0m '
    read P1
    printf '\033[33mPAIRING CODE:\033[0m '
    read CODE

    adb pair 127.0.0.1:$P1 $CODE && break

    printf '\033[31mFAILED, RETRY\033[0m\n'
done


while :; do
    printf '\033[33mPORT_ADB:\033[0m '
    read P2

    adb connect 127.0.0.1:$P2

    if adb devices | grep -q '[[:space:]]device$'; then
        break
    fi

    printf '\033[31mNO DEVICE, RETRY\033[0m\n'
    adb disconnect
done

printf '\n\033[32m[✓] ADB Connected\033[0m\n'
printf '\033[32m[✓] Running AppManager server...\033[0m\n\n'


adb shell sh /data/user_de/0/io.github.muntashirakon.AppManager/cache/run_server.sh 60001 mug-lever-tutu

printf '\n\033[32m[✓]\033[0m\n'
