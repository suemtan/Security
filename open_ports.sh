#!/bin/sh

#set eth interface
#ifconfig eth0 192.168.0.20

#install firewall
yum install firewalld

# enable firewall

#systemctl unmask firewalld
systemctl start firewalld
systemctl enable firewalld

# disable services you do not need - printers
systemctl disable cups


# route incoming traffic into a specific source, add the source to that zone (192.168.0.0/24)
#firewall-cmd --zone=work --add-source=192.168.0.20
#firewall-cmd --reload

#assign eth network interface to specified zone
#firewall-cmd --permanent --zone=work --change-interface=eth0

#check which zone associated with eth0 interface
#firewall-cmd --get-zone-of-interface=eth0 

#configuring ip address masquerading
firewall-cmd --zone=work --add-masquerade

# add firewall rule for open ports
firewall-cmd --permanent --zone=work --add-service=ssh
firewall-cmd --permanent --zone=work --add-service=http
firewall-cmd --permanent --zone=work --add-service=https
firewall-cmd --permanent --zone=work --add-port=22/tcp
firewall-cmd --permanent --zone=work --add-port=37/tcp
firewall-cmd --permanent --zone=work --add-port=37/udp

firewall-cmd --permanent --zone=work --add-port=42/tcp
firewall-cmd --permanent --zone=work --add-port=42/udp

firewall-cmd --permanent --zone=work --add-port=50/udp
firewall-cmd --permanent --zone=work --add-port=51/udp
firewall-cmd --permanent --zone=work --add-port=53/udp
firewall-cmd --permanent --zone=work --add-port=113/tcp
firewall-cmd --permanent --zone=work --add-port=113/udp

firewall-cmd --permanent --zone=work --add-port=123/udp
firewall-cmd --permanent --zone=work --add-port=319/udp
firewall-cmd --permanent --zone=work --add-port=320/udp
firewall-cmd --permanent --zone=work --add-port=443/tcp
firewall-cmd --permanent --zone=work --add-port=514/tcp
firewall-cmd --permanent --zone=work --add-port=519/tcp
firewall-cmd --permanent --zone=work --add-port=519/udp
firewall-cmd --permanent --zone=work --add-port=525/tcp
firewall-cmd --permanent --zone=work --add-port=525/udp
firewall-cmd --permanent --zone=work --add-port=526/tcp
firewall-cmd --permanent --zone=work --add-port=526/udp
firewall-cmd --permanent --zone=work --add-port=624/tcp
firewall-cmd --permanent --zone=work --add-port=624/udp
firewall-cmd --permanent --zone=work --add-port=873/tcp
firewall-cmd --permanent --zone=work --add-port=5696/tcp
firewall-cmd --permanent --zone=work --add-port=8417/udp

#firewall-cmd --zone=work --list-all

#restart firewalld
systemctl restart firewalld
systemctl status firewalld


#check active zones
firewall-cmd --get-active-zones

