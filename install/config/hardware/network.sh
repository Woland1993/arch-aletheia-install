# Ensure network services will be started
sudo systemctl enable systemd-networkd.service
sudo systemctl enable systemd-resolved.service
sudo systemctl enable iwd.service

# Archinstall normally creates these DHCP profiles, but VM installs can miss
# them. Keep them here so Aletheia does not depend on installer defaults.
sudo mkdir -p /etc/systemd/network

sudo tee /etc/systemd/network/20-ethernet.network >/dev/null <<'EOF'
[Match]
# Matching with "Type=ether" causes issues with containers because it also matches virtual Ethernet interfaces (veth*).
# See https://bugs.archlinux.org/task/70892
# Instead match by globbing the network interface name.
Name=en*
Name=eth*

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
MulticastDNS=yes

# systemd-networkd does not set per-interface-type default route metrics
# https://github.com/systemd/systemd/issues/17698
# Explicitly set route metric, so that Ethernet is preferred over Wi-Fi and Wi-Fi is preferred over mobile broadband.
# Use values from NetworkManager. From nm_device_get_route_metric_default in
# https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/blob/main/src/core/devices/nm-device.c
[DHCPv4]
RouteMetric=100

[IPv6AcceptRA]
RouteMetric=100
EOF

sudo tee /etc/systemd/network/20-wlan.network >/dev/null <<'EOF'
[Match]
Name=wl*

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
MulticastDNS=yes

# systemd-networkd does not set per-interface-type default route metrics
# https://github.com/systemd/systemd/issues/17698
# Explicitly set route metric, so that Ethernet is preferred over Wi-Fi and Wi-Fi is preferred over mobile broadband.
# Use values from NetworkManager. From nm_device_get_route_metric_default in
# https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/blob/main/src/core/devices/nm-device.c
[DHCPv4]
RouteMetric=600

[IPv6AcceptRA]
RouteMetric=600
EOF

sudo tee /etc/systemd/network/20-wwan.network >/dev/null <<'EOF'
[Match]
Name=ww*

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes

# systemd-networkd does not set per-interface-type default route metrics
# https://github.com/systemd/systemd/issues/17698
# Explicitly set route metric, so that Ethernet is preferred over Wi-Fi and Wi-Fi is preferred over mobile broadband.
# Use values from NetworkManager. From nm_device_get_route_metric_default in
# https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/blob/main/src/core/devices/nm-device.c
[DHCPv4]
RouteMetric=700

[IPv6AcceptRA]
RouteMetric=700
EOF

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
