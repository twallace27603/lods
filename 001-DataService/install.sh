#!/bin/sh
apt-get update
apt-get install -y python3
cp svrtest.py /etc/init.d/svrtest.py
chmod +x /etc/init.d/svrtest.py
update-rc.d svrtest.py defaults 80 
reboot