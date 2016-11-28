# How to use

```
cd
git clone https://github.com/maxmureev/OpenVPN-Docker-Alpine.git
cd OpenVPN-Docker-Alpine
./init.sh
```

Start OpenVPN
```
docker run -d --name=openvpn -v ~/OpenVPN-Docker-Alpine/volumes:/etc/openvpn --privileged -p 1194:1194/udp --net=host openvpn
```

A short description in Russian [here](http://notessysadmin.com/openvpn-in-docker-container)
