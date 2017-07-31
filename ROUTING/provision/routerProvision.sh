sudo sysctl -w net.ipv4.ip_forward=1
sudo route add -net 0.0.0.0 netmask 0.0.0.0 gw 172.16.3.3
