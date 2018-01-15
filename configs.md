# VPN
Openvpn doesn't properly restart when suspending and resuming
Config is needed to kill it and force to restart when killed.

`/usr/lib/systemd/system-sleep/vpn.sh`
```bash
#!/bin/sh
if [ "$1" == "pre" ]
then
  killall openvpn
fi
```

`/etc/systemd/system/openvpn-client@.service.d/restart.conf`
```
[Service]
Restart=always
```

# Emoji
After installing `noto-emoji-fonts` you need this config to choose emoji priority over other fonts.

`/etc/fonts/local.conf`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match>
    <test name="family">
      <string>serif</string>
    </test>
    <edit name="family" mode="prepend" binding="weak">
      <string>Emoji</string>
    </edit>
  </match>

  <match>
    <test name="family">
      <string>sans-serif</string>
    </test>
    <edit name="family" mode="prepend" binding="weak">
      <string>Emoji</string>
    </edit>
  </match>

  <match>
    <test name="family">
      <string>monospace</string>
    </test>
    <edit name="family" mode="prepend" binding="weak">
      <string>Emoji</string>
    </edit>
  </match>
</fontconfig>
```

# Touchpad
Needed on HiDPI screen to increase cursor velocity

`/etc/X11/xorg.conf.d/99-libinput-custom.conf`
```
Section "InputClass"
  Identifier "Mouse accel config"
  MatchDriver "libinput"
  MatchProduct "Touchpad"
  Option "AccelSpeed" "0.8"
EndSection
```

Making touchpads bearable on libinput

`/etc/X11/xorg.conf.d/30-touchpad.conf`
```
Section "InputClass"
    Identifier "libinput touchpad catchall"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
```

# Display
Config so `xbacklight` recognizes intel backlight. Also config a bunch of intel crap.

`/etc/X11/xorg.conf.d/10-backlight.conf`
```
Section "Device"
    Identifier  "Intel Graphics"
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
    Option      "AccelMethod" "sna"
    Option      "TearFree" "true"
EndSection
```
