#!/bin/bash
##Set the SELinux State##

/bin/echo "Taking backup of /etc/selinux/config file"
/bin/cp -p /etc/selinux/config /var/tmp/bkp_selinuxconfig_`date +"%d%m%Y%T"`
/bin/echo "Backup has been completed and it is under /var/tmp"

status=`cat /etc/selinux/config | grep -v "^#" | grep -i SELINUX=`

if [[ "$?" == 1 ]];
        then
                /bin/echo "SELINUX=enforcing" >> /etc/selinux/config
                /bin/echo "Enforcing mode enabled on the server,but it requires a server reboot to apply change"
        else
                value=`cat /etc/selinux/config | grep -v "^#" | grep -i SELINUX= | cut -d "=" -f2`
                /bin/sed -i 's/SELINUX='"$value"'/SELINUX=enforcing/g' /etc/selinux/config
                /bin/echo "Selinux Config file has been updated,but it requires a server reboot to apply change"
fi
		
        