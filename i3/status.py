from i3pystatus import Status
from i3pystatus import get_module
from i3pystatus.core.command import run_through_shell

status = Status()

# Displays clock
status.register("clock",
        format="%a %-d %b %H:%M",)

# Shows the average load of the last minute and the last 5 minutes
status.register("load")

status.register("battery",
    format="{status} {percentage:.2f}% {remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=10,
    status={
        "DIS": "🔋",
        "CHR": "🔌",
        "FULL": "🔥",
    },)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="wlp58s0",
    format_up="📶 {essid} {quality:3.0f}%",)

status.register("openvpn",
    # vpn_name="AU_Melbourne",
    vpn_name="US_California",
    use_new_service_name=True,)

status.register("disk",
    path="/",
    format="{avail}/{total}G",)

status.register("disk",
    path="/home",
    format="{avail}/{total}G",)

# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="🎵 {volume}",)

status.register("backlight",
    format="💡 {percentage}",)

@get_module
def enable_dpms(self):
    if self.status:
        run_through_shell("xset -dpms s off", True)
    else:
        run_through_shell("xset +dpms s on", True)
        run_through_shell("xset s 120 10", True)

status.register("dpms",
    on_leftclick=enable_dpms)

status.run()
