#!/bin/bash

sudo su
apt-get update
apt-get install isc-dhcp-server -y
cat /vagrant/provision/ubuntu_isc-dhcp-server > /etc/default/isc-dhcp-server
cat /vagrant/provision/ubuntu_dhcpd.conf >  /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart
