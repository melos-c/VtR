#!/usr/bin/env bash

date -R
echo "====== Installing Prerequisite ==========="
read -p "Press [Enter] key to Continue..."


yum install -y zip unzip
yum install net-tools
yum -y update
mkdir /etc/v2ray/
mkdir v2ray
mkdir /usr/bin/v2ray
mkdir /var/log/v2ray

echo "====== Openning Necessary Ports =========="
read -p "Press [Enter] key to Continue..."
firewall-cmd --zone=public --add-port=10086/tcp --permanent
firewall-cmd --zone=public --add-port=10087/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=444/tcp --permanent
firewall-cmd --zone=public --add-port=20087/tcp --permanent
firewall-cmd --zone=public --add-port=20087/udp --permanent
#firewall-cmd --permanent --zone=public --add-service=http 
#firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

echo "====== Installing ACME and SSL Cert & Key ====="
read -p "Press [Enter] key to Continue..."
yum -y install socat.x86_64
curl  https://get.acme.sh | sh
source ~/.bashrc
~/.acme.sh/acme.sh --upgrade --auto-upgrade
#read -p "Input Domain Name:" domain
sudo ~/.acme.sh/acme.sh --issue -d huaxiatech.xyz --standalone -k ec-256
#将证书生成到 /etc/v2ray/ 文件夹，更新证书之后还得把新证书生成到 /etc/v2ray
sudo ~/.acme.sh/acme.sh --installcert -d huaxiatech.xyz --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
# Manually renew the cert when it expires...
#sudo ~/.acme.sh/acme.sh --renew -d huaxiatech.xyz --force --ecc
#acme.sh --cron -f

echo "===== Installing V2Ray ==================="
read -p "Press [Enter] key to Continue..."
wget https://raw.githubusercontent.com/melos-c/VtR/master/updateV2ray.sh
wget https://github.com/v2ray/v2ray-core/releases/download/v4.22.0/v2ray-linux-64.zip
unzip v2ray-linux-64.zip -d v2ray

cp ./v2ray/v2ray /usr/bin/v2ray/v2ray
cp ./v2ray/v2ctl /usr/bin/v2ray/v2ctl
cp ./v2ray/geoip.dat /usr/bin/v2ray/geoip.dat
cp ./v2ray/geosite.dat /usr/bin/v2ray/geosite.dat
#cp ./v2ray/vpoint_vmess_freedom.json /etc/v2ray/config.json
cp ./v2ray/systemd/v2ray.service /usr/lib/systemd/system
touch /var/log/v2ray/access.log
touch /var/log/v2ray/error.log
touch /var/run/v2ray.pid
wget -O /etc/v2ray/config.json https://raw.githubusercontent.com/melos-c/VtR/master/v2rayconfig.server


rm -rf v2ray
rm -f v2ray-linux-64.zip


systemctl enable v2ray
systemctl start v2ray
systemctl status v2ray

echo "====== List the Listening Ports =========="
netstat -lpnt

echo "====== Installing BBR ===================="
read -p "Press [Enter] key to Continue..."
wget –no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x bbr.sh
./bbr.sh
reboot

# Verify if BBR is installed successfully.
#lsmod | grep bbr
#cd ..
#cd ~

