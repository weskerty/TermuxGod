#!/data/data/com.termux/files/usr/bin/sh

SF="$HOME/.sshx_last"

LU=$(sed -n 1p "$SF" 2>/dev/null)
LI=$(sed -n 2p "$SF" 2>/dev/null)
LP=$(sed -n 3p "$SF" 2>/dev/null)
LM=$(sed -n 4p "$SF" 2>/dev/null)
LK=$(sed -n 5p "$SF" 2>/dev/null)

printf "IP [%s]: " "$LI"; read IP
printf "User [%s]: " "$LU"; read U
printf "Port [%s]: " "$LP"; read P
printf "Auth method (password/key) [%s]: " "$LM"; read M

[ -z "$IP" ] && IP="$LI"
[ -z "$U" ]  && U="$LU"
[ -z "$P" ]  && P=22
[ -z "$M" ]  && M=password

case "$M" in
  password|key) ;;
  *) echo "❌ Auth method must be password or key"; exit 1 ;;
esac

if [ "$M" = "key" ]; then
    printf "Key path [%s]: " "$LK"
    read K
    [ -z "$K" ] && K="$LK"


    K=$(eval echo "$K")

    if [ ! -f "$K" ]; then
        echo "❌ Key not found: $K"
        exit 1
    fi
fi

[ -z "$IP" ] || [ -z "$U" ] && exit 1


{
  echo "$U"
  echo "$IP"
  echo "$P"
  echo "$M"
  echo "$K"
} > "$SF"


pkill -f termux.x11 2>/dev/null
pulseaudio -k 2>/dev/null

pulseaudio --start \
  --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" \
  --exit-idle-time=-1

export XDG_RUNTIME_DIR="$TMPDIR"

termux-x11 :0 >/dev/null &
sleep 3

am start --user 0 \
  -n com.termux.x11/com.termux.x11.MainActivity \
  >/dev/null 2>&1

sleep 1

SSH_OPTS="-Y -p $P -L 4714:127.0.0.1:4713"

[ "$M" = "key" ] && SSH_OPTS="$SSH_OPTS -i $K"

env DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4714 \
ssh $SSH_OPTS "$U@$IP"
