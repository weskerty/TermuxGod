#!/data/data/com.termux/files/usr/bin/bash
echo "\e[1;33m⚠️ ACEPTA LOS PERMISOS CUANDO APAREZCAN \e[0m"
echo "\e[1;33m⚠️ CONCEDE PERMISOS DE ALMACENAMIENTO Y EJECUCION \e[0m"
sleep 5
printf 'n\n' | termux-setup-storage
sleep 7
termux-wake-lock
apt-get update
pkg i -y tur-repo x11-repo
apt update -y && yes | apt upgrade && pkg install -y android-tools
am start -a android.settings.APPLICATION_DEVELOPMENT_SETTINGS
am start -a android.settings.WIRELESS_DEBUGGING_SETTINGS
read -p "PORT_PAIR: " P1
adb pair 127.0.0.1:$P1
read -p "PORT_ADB: " P2
adb connect 127.0.0.1:$P2
adb devices
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
adb shell settings put global settings_enable_monitor_phantom_procs false
adb shell cmd deviceidle whitelist +com.termux
adb shell cmd appops set com.termux RUN_IN_BACKGROUND allow
adb shell cmd appops set com.termux RUN_ANY_IN_BACKGROUND allow
adb shell cmd appops set com.termux SYSTEM_EXEMPT_FROM_ACTIVITY_BG_START_RESTRICTION allow
adb shell cmd appops set com.termux SYSTEM_EXEMPT_FROM_HIBERNATION allow
adb shell cmd appops set com.termux SYSTEM_EXEMPT_FROM_POWER_RESTRICTIONS allow
adb shell cmd appops set com.termux SYSTEM_EXEMPT_FROM_SUSPENSION allow
adb shell cmd appops set com.termux WAKE_LOCK allow
adb kill-server
