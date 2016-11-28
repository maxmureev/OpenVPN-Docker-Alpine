#!/bin/sh

if [ ! -f /etc/openvpn/keys/ta.key ]; then
    cd /etc/openvpn/keys/
    openvpn --genkey --secret ta.key
fi
iptables -A INPUT -p UDP --dport 1194 -j ACCEPT
iptables -A INPUT -s 10.15.0.0/24 -j ACCEPT
iptables -A FORWARD -s 10.15.0.0/24 -j ACCEPT
iptables -A FORWARD -d 10.15.0.0/24 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.15.0.0/24 -j MASQUERADE

exec openvpn --config /etc/openvpn/server.conf
