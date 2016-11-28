# How to use

```
git clone https://github.com/maxmureev/OpenVPN-Docker-Alpine.git
cd OpenVPN-Docker-Alpine
docker build . -t openvpn

git clone https://github.com/OpenVPN/easy-rsa.git
cd easy-rsa/easyrsa3/
cp vars.example vars
./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-dh
./easyrsa gen-req vpn-server nopass
./easyrsa sign-req server vpn-server

cp pki/ca.crt ../../volumes/keys
cp pki/issued/vpn-server.crt ../../volumes/keys
cp pki/private/vpn-server.key ../../volumes/keys
cp pki/dh.pem ../../volumes/keys

docker run -d --name=openvpn -v ~/openvpn/volumes:/etc/openvpn --privileged -p 1194:1194/udp --net=host openvpn
```
