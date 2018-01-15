dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

xrdb -merge ~/.Xresources
xset s 120 10

export MOZ_USE_XINPUT2=1

exec i3
