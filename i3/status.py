from i3pystatus import Status
from i3pystatus import get_module
from i3pystatus.core.command import run_through_shell

status = Status()

# Displays clock
status.register("clock",
        format="%a %-d %b %H:%M",)

# Shows the average load of the last minute and the last 5 minutes
status.register("load")

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="enp3s0",
    format_up="{v4cidr}",)

status.register("openvpn",
    vpn_name="AU_Melbourne",
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

@get_module
def enable_dpms(self):
    if self.status:
        run_through_shell("xset -dpms s off", True)
    else:
        run_through_shell("xset +dpms s on", True)
        run_through_shell("xset s 120 5", True)

status.register("dpms",
    on_leftclick=enable_dpms)

status.run()
