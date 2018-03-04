#!/bin/sh
apt-get update
apt-get install -y python3
cp svrTest.py /etc/init.d/svrTest.py
chmod +x /etc/init.d/svrTest.py
update-rc.d svrTest.py defaults 80 
reboot