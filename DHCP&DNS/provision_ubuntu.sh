#!/bin/bash

sudo su
apt-get update
#DHCP
apt-get install isc-dhcp-server -y
cat /vagrant/provision/ubuntu_isc-dhcp-server > /etc/default/isc-dhcp-server
cat /vagrant/provision/ubuntu_dhcpd.conf > /etc/dhcp/dhcpd.conf
cat /vagrant/dhcp2_key.conf > /etc/dhcp/dhcp2_key.conf && echo "OK"
chown dhcpd:dhcpd /etc/dhcp/dhcp2_key.conf
printf "search serhiiDevOps.org.\nnameserver 172.16.60.1\n" > /etc/resolv.conf 
service isc-dhcp-server restart
