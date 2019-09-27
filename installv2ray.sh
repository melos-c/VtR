yum install -y zip unzip
wget https://github.com/v2ray/v2ray-core/releases/download/v4.20.0/v2ray-linux-64.zip

mkdir v2ray
mkdir /usr/bin/v2ray
mkdir /etc/v2ray/
mkdir /var/log/v2ray

unzip v2ray-linux-64.zip -d v2ray
cd v2ray

cp v2ray /usr/bin/v2ray/v2ray
cp v2ctl /usr/bin/v2ray/v2ctl
cp geoip.dat /usr/bin/v2ray/geoip.dat
cp geosite.dat /usr/bin/v2ray/geosite.dat
cp vpoint_vmess_freedom.json /etc/v2ray/config.json
cp ./systemd/v2ray.service /usr/lib/systemd/system
touch /var/log/v2ray/access.log
touch /var/log/v2ray/error.log
touch /var/run/v2ray.pid
systemctl start v2ray
systemctl status v2ray
systemctl enable v2ray

firewall-cmd --zone=public --add-port=10086/tcp --permanent
firewall-cmd --reload
