dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

xrdb -merge ~/.Xresources
xset s 120 10
xset r rate 200 25

export MOZ_USE_XINPUT2=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1

exec i3
