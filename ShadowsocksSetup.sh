#!/usr/bin/env bash
echo
echo "======== SETUP SS PORT/PASSWORD/ENCRYPTION ========"

read -p "Number of New Port [2048-65535]:" shadowsocksport
read -p "Encryption Method [aes-256-cfb]:" encryption
read -p "Password:" pw

cat >/etc/shadowsocks.json<<eof
{
    "server":"0.0.0.0",
    "server_port":$shadowsocksport,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"$pw",
    "timeout":300,
    "method":"$encryption",
    "fast_open":false
}
eof

firewall-cmd --zone=public --add-port=$shadowsocksport/tcp --permanent
firewall-cmd --zone=public --add-port=$shadowsocksport/udp --permanent
firewall-cmd --reload
ssserver -c/etc/shadowsocks.json -d restart
echo "========COMPLETED========"

#firewall-cmd --zone=public --remove-port=$shadowsocksport/udp --permanent
#!/bin/sh
#rm -f /etc/shadowsocks.json
