# How to use

```
git clone https://github.com/maxmureev/OpenVPN-Docker-Alpine.git
cd OpenVPN-Docker-Alpine
docker build . -t openvpn

# Initialise CA
git clone https://github.com/OpenVPN/easy-rsa.git
cd easy-rsa/easyrsa3/
cp vars.example vars
./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-dh
# Generate server keys
./easyrsa gen-req vpn-server nopass
./easyrsa sign-req server vpn-server
# Copy keys to volume dir
cp pki/ca.crt ../../volumes/keys
cp pki/issued/vpn-server.crt ../../volumes/keys
cp pki/private/vpn-server.key ../../volumes/keys
cp pki/dh.pem ../../volumes/keys

# Generate client keys
./easyrsa gen-req USER_1 # or ./easyrsa gen-req USER_1 nopass
./easyrsa sign-req client USER_1

# Start 
docker run -d --name=openvpn -v ~/openvpn/volumes:/etc/openvpn --privileged -p 1194:1194/udp --net=host openvpn
```
