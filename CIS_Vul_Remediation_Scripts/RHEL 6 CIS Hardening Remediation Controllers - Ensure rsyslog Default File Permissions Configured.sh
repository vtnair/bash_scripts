#!/bin/bash
##Ensure rsyslog Default File Permissions Configured##

/bin/echo "Taking backup of /etc/rsyslog.conf"
cp -p /etc/rsyslog.conf /var/tmp/bkp_rsyslog_`date +"%d%m%Y%T"`
echo "rsyslog.cof backup completed successfully and it is located under /var/tmp"

rsys=`cat /etc/rsyslog.conf |grep -v "^#" | grep -i "\$FileCreateMode"`
if [[ "$?" == 1 ]];
        then
                /bin/echo "\$FileCreateMode 0640" >> /etc/rsyslog.conf
                /bin/echo "rsyslog default file permissions configured. Restarting rsyslog"
                /sbin/service rsyslog restart
                if [[ "$?" == 0 ]];
                        then
                                /bin/echo "rsyslog restarted successfully"
                        else
                                /bin/echo "Found some issue with rsyslog while restarting, kindly restart manually.."
                fi
        else
                value=`cat /etc/rsyslog.conf |grep -v "^#" | grep -i "\$FileCreateMode" | awk '{print $2}'`
                echo "Updating the value on /etc/rsyslog.conf"
                sed -i 's/^\$FileCreateMode\(.*\)/\$FileCreateMode 0640/g' /etc/rsyslog.conf
                echo "value has been updated successfully. Restarting rsyslog"
                /sbin/service rsyslog restart
                if [[ "$?" == 0 ]];
                        then
                                /bin/echo "SSHD restarted successfully"
                        else
                                /bin/echo "Found some issue with rsyslog while restarting service, kinldy restart manually..."
                fi
fi
	




		


		
