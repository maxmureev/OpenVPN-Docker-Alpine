#!/bin/sh

docker build . -t openvpn > /dev/null

if [ ! -d easy-rsa ]; then
git clone https://github.com/OpenVPN/easy-rsa.git
fi
cd easy-rsa/easyrsa3/
cp vars.example vars

if [ ! -d pki ]; then
    ./easyrsa init-pki
fi
if [ ! -f ../../volumes/keys/dh.pem ]; then
    ./easyrsa gen-dh
    cp pki/dh.pem ../../volumes/keys
fi

if [ ! -f ../../volumes/keys/ca.crt ]; then
    ./easyrsa build-ca nopass
    cp pki/ca.crt ../../volumes/keys
fi

# Generate server keys
if [ ! -f ../../volumes/keys/vpn-server.crt ]; then
./easyrsa build-server-full vpn-server nopass
cp pki/issued/vpn-server.crt ../../volumes/keys
cp pki/private/vpn-server.key ../../volumes/keys
fi

# Generate client keys
#./easyrsa build-server-full USER nopass
