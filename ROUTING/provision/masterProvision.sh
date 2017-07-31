#!/bin/bash
su
yum update -y

#DHCP
yum install dhcp -y
cat /vagrant/dhcpConf/centos_dhcpd.conf > /etc/dhcp/dhcpd.conf
cat /vagrant/dhcpConf/centos_dhcpd > /etc/sysconfig/dhcpd

#DNS
yum install bind bind-utils -y
cat /vagrant/dnsConf/centos_named.conf > /etc/named.conf

#TRANSFERING ZONES
cat /vagrant/dnsConf/zones/forward.NET1.DevOps > /var/named/data/forward.NET1.DevOps
cat /vagrant/dnsConf/zones/reverse.NET1.DevOps > /var/named/data/reverse.NET1.DevOps
cat /vagrant/dnsConf/zones/reverse.NET2.DevOps > /var/named/data/reverse.NET2.DevOps
#CONFIGURING PERMISIONS
chmod u=rwx,g=rx,o=rx -R /var/named
chown -v -R named:named /var/named
chown -v named:named /etc/named.conf
#ROUTING
sudo ip route add 0.0.0.0/0 via 172.16.1.2 dev 

#EDITING RESOLV.CONF 
printf "search ns1.NET1.DevOps.net\nnameserver 172.16.1.1\nsearch ns1.NET2.DevOps.net\nnameserver 172.16.2.1\nnameserver 8.8.8.8" > /etc/resolv.conf

#EDITING  
cat /vagrant/interfaceConf/ifcfg-eth1 >  /etc/sysconfig/network-scripts/ifcfg-eth1
cat /vagrant/interfaceConf/ifcfg-eth2 >  /etc/sysconfig/network-scripts/ifcfg-eth2
#PERMISIONS FOR DHCPD TO RNDC KEY
sudo chmod o+r /etc/rndc.key
#RESTARTING SYSTEMS
systemctl restart named
systemctl restart dhcpd

