#!/bin/bash
##Set SSH MaxAuthTries to 4 or Less##
echo "Taking backup of SSHD_Config"
cp -p /etc/ssh/sshd_config /var/tmp/BKP_sshd_config_`date +"%d%m%Y%T"`
echo "SSHD_config backup completed successfully and its located under /var/tmp"

ssh_out=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i MaxAuthTries`
if [[ "$?" == 1 ]];
        then
        echo "MaxAuthTries 4" >> /etc/ssh/sshd_config
        echo "Appended MaxAuthTries and restarting sshd"
        /bin/systemctl restart sshd
        echo "SSHD restarted successfully"
else
        echo "Updating the value for MaxAuthTries"
        value=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i MaxAuthTries | awk '{print $NF}'`
        /bin/sed -i 's/MaxAuthTries '"$value"'/MaxAuthTries 4/g' /etc/ssh/sshd_config
        echo "value has been updated successfully. Restarting SSHD"
        /bin/systemctl restart sshd
        echo "SSHD restarted successfully"
fi
