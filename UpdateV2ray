read -p "Enter Full Revision Number of V2RAY [eg. 4.22.0]: " ver
wget https://github.com/v2ray/v2ray-core/releases/download/$ver/v2ray-linux-64.zip
unzip v2ray-linux-64.zip -d v2ray

systemctl stop v2ray
rm -f /usr/bin/v2ray/v2ray
rm -f /usr/bin/v2ray/v2ctl
rm -f /usr/bin/v2ray/geoip.dat
rm -f /usr/bin/v2ray/geosite.dat
rm -f /usr/lib/systemd/system/v2ray.service

cp ./v2ray/v2ray /usr/bin/v2ray/v2ray
cp ./v2ray/v2ctl /usr/bin/v2ray/v2ctl
cp ./v2ray/geoip.dat /usr/bin/v2ray/geoip.dat
cp ./v2ray/geosite.dat /usr/bin/v2ray/geosite.dat
cp ./v2ray/systemd/v2ray.service /usr/lib/systemd/system

rm -rf v2ray
rm -f v2ray-linux-64.zip

systemctl daemon-reload
#systemctl enable v2ray
systemctl start v2ray
reboot
