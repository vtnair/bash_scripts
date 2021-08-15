#!/bin/bash
##Verify That ClientAliveInterval Is Set to 300 or Less##

echo "Taking backup of SSHD_Config"
cp -p /etc/ssh/sshd_config /var/tmp/BKP_sshd_config_`date +"%d%m%Y%T"`
echo "SSHD_config backup completed successfully and its located under /var/tmp"

ssh_out=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i ClientAliveInterval`
if [[ "$?" == 1 ]];
        then
        echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config
        echo "Appended ClientAliveInterval and restarting sshd"
        /sbin/service sshd restart
	if [[ "$?" == 0 ]];
		then
        		/bin/echo "SSHD restarted successfully"
		else
			/bin/echo "Found some issue with sshd while restarting service, kinldy restart manually..."
	fi	
else
        echo "Updating the value for ClientAliveInterval"
        value=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i ClientAliveInterval | awk '{print $NF}'`
        /bin/sed -i 's/ClientAliveInterval '"$value"'/ClientAliveInterval 300/g' /etc/ssh/sshd_config
        echo "value has been updated successfully. Restarting SSHD"
        /sbin/service sshd restart
	if [[ "$?" == 0 ]];
		then
        		/bin/echo "SSHD restarted successfully"
		else
			/bin/echo "Found some issue with sshd while restarting service, kinldy restart manually..."
	fi	
fi