#!/bin/bash
su
yum update -y
#DHCP
yum install dhcp -y
cat /vagrant/provision/centos_dhcpd.conf > /etc/dhcp/dhcpd.conf
cat /vagrant/provision/centos_dhcpd > /etc/sysconfig/dhcpd
systemctl restart dhcpd
systemctl enable dhcpd
#DNS
yum install bind bind-utils -y
cat /vagrant/provision/centos_named.conf > /etc/named.conf
cat /vagrant/provision/forward.serhiipanchenko > /var/named/forward.serhiipanchenko
cat /vagrant/provision/reverse.serhiipanchenko > /var/named/reverse.serhiipanchenko
systemctl enable named
systemctl start named
firewall-cmd --permanent --add-port=53/tcp
firewall-cmd --permanent --add-port=53/udp
firewall-cmd --reload
chgrp named -R /var/named
chown -v root:named /etc/named.conf
restorecon -rv /var/named
restorecon /etc/named.conf
cat /vagrant/provision/ifcfg-eth1 > /etc/sysconfig/network-scripts/ifcfg-eth1

systemctl restart network