#!/bin/bash
##Ensure ssh LoginGraceTime Is Set to One Minute or Less##
echo "Taking backup of SSHD_Config"
cp -p /etc/ssh/sshd_config /var/tmp/BKP_sshd_config_`date +"%d%m%Y%T"`
echo "SSHD_config backup completed successfully and its located under /var/tmp"

ssh_out=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i LoginGraceTime`
if [[ "$?" == 1 ]];
        then
        echo "LoginGraceTime 60" >> /etc/ssh/sshd_config
        echo "Appended LoginGracetime and restarting sshd"
        /bin/systemctl restart sshd
        echo "SSHD restarted successfully"
else
        echo "Updating the value for LoginGracetime"
        value=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i LoginGraceTime | awk '{print $NF}'`
        /bin/sed -i 's/LoginGraceTime '"$value"'/LoginGraceTime 60/g' /etc/ssh/sshd_config
        echo "value has been updated successfully. Restarting SSHD"
        /bin/systemctl restart sshd
        echo "SSHD restarted successfully"
fi
