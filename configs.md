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

# Fonts and emoji
After installing `noto-emoji-fonts` you need this config to choose emoji priority over other fonts. This also sets default fonts to the Noto family and Source Code Pro.

This could also be in `~/fontconfig/fonts.conf` I prefer system wide configs.
`/etc/fonts/local.conf`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <!-- Set preferred serif, sans serif, and monospace fonts. -->
  <alias>
    <family>sans-serif</family>
    <prefer><family>Noto Sans</family></prefer>
  </alias>
  <alias>
    <family>sans</family>
    <prefer><family>Noto Sans</family></prefer>
  </alias>
  <alias>
    <family>monospace</family>
    <prefer><family>Source Code Pro</family></prefer>
  </alias>

  <!-- Set emoji as fallback font -->
  <match>
    <test name="family"><string>serif</string></test>
    <edit name="family" mode="prepend" binding="weak">
      <string>Emoji</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>sans-serif</string></test>
    <edit name="family" mode="prepend" binding="weak">
      <string>Emoji</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>monospace</string></test>
    <edit name="family" mode="prepend" binding="weak">
      <string>Emoji</string>
    </edit>
  </match>

  <!-- override some popular fonts, since some fonts *cough* Nimbus *cough* are aggressively aliasing MS fonts :| -->
  <alias binding="same">
    <family>Ariel</family>
    <prefer><family>Noto Sans</family></prefer>
  </alias>
  <alias binding="same">
    <family>Helvetica</family>
    <prefer><family>Noto Sans</family></prefer>
  </alias>
  <alias binding="same">
    <family>Times</family>
    <prefer><family>Noto Serif</family></prefer>
  </alias>
  <alias binding="same">
    <family>Courier</family>
    <prefer><family>Source Code Pro</family></prefer>
  </alias>
</fontconfig>
```

# Touchpad
Making touchpads bearable on libinput
Needed on HiDPI screen to increase cursor velocity

`/etc/X11/xorg.conf.d/99-libinput-custom.conf`
```
Section "InputClass"
  Identifier "Mouse accel config"
  MatchDriver "libinput"
  MatchProduct "Touchpad"
  Option "AccelSpeed" "0.8"
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

# Power button
Configure power button to put laptop to sleep (not shutdown).

Find `#HandlePowerKey=poweroff` in `/etc/systemd/logind.conf`. Uncomment it and change `poweroff` to `suspend`
