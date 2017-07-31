sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s 172.16.3.0/26 -o eth0 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 172.16.2.0/27 -o eth0 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 172.16.1.0/29 -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -s 172.16.3.0/26 -o eth0 -j ACCEPT
sudo iptables -A FORWARD -d 172.16.3.0/26 -o eth0 -j ACCEPT
sudo iptables -A FORWARD -s 172.16.2.0/27 -o eth0 -j ACCEPT
sudo iptables -A FORWARD -d 172.16.2.0/27 -o eth0 -j ACCEPT
sudo iptables -A FORWARD -s 172.16.1.0/29 -o eth0 -j ACCEPT
sudo iptables -A FORWARD -d 172.16.1.0/29 -o eth0 -j ACCEPT
sudo route add -net 172.16.2.0 netmask 255.255.255.224 gw 172.16.3.2
sudo route add -net 172.16.1.0 netmask 255.255.255.248 gw 172.16.3.1
