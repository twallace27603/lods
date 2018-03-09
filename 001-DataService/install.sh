apt-get update
apt-get install -y python3
mkdir /usr/svrTest

cp svrtest.py /usr/serverTest
chmod +x /usr/serverTest/svrtest.py

cp svrteststart.sh /etc/init.d
chmod +x /etc/init.d/svrteststart.sh

update-rc.d svrteststart.sh defaults 
/usr/serverTest/svrtest.py &