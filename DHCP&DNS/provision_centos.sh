#!/bin/bash
su
yum update -y

#DHCP
yum install dhcp -y
cat /vagrant/provision/centos_dhcpd.conf > /etc/dhcp/dhcpd.conf
cat /vagrant/provision/centos_dhcpd > /etc/sysconfig/dhcpd
#DNS
yum install bind bind-utils -y
cat /vagrant/provision/dns/centos_named.conf > /etc/named.conf
cat /vagrant/provision/dns/forward.serhiipanchenko > /var/named/data/forward.serhiipanchenko
cat /vagrant/provision/dns/reverse.serhiipanchenko > /var/named/data/reverse.serhiipanchenko
cat /vagrant/provision/dns/serhiiDevOps.org > /var/named/data/serhiiDevOps.org
chmod 755 -R /var/named
chown -v -R named:named /var/named
chown -v named:named /etc/named.conf
restorecon -rv /var/named
restorecon /etc/named.conf
cat /vagrant/provision/dns/ifcfg-eth1 > /etc/sysconfig/network-scripts/ifcfg-eth1
systemctl restart network
systemctl restart named
cat /etc/rndc.key > /vagrant/dhcp2_key.conf
systemctl restart dhcpd
systemctl restart named
printf "search serniipanchenko.local\nnameserver 172.16.60.1\n" > /etc/resolv.conf 
