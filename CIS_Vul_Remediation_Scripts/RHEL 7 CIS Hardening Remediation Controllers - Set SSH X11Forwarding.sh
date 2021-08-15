#!/bin/bash
##Disbale ssh X11Forwarding ##
echo "Taking backup of SSHD_Config"
cp -p /etc/ssh/sshd_config /var/tmp/BKP_sshd_config_`date +"%d%m%Y%T"`
echo "SSHD_config backup completed successfully and its located under /var/tmp"

ssh_out=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i X11Forwarding`
if [[ "$?" == 1 ]];
        then
        echo "X11Forwarding no" >> /etc/ssh/sshd_config
        echo "Appended X11Forwarding and restarting sshd"
        /bin/systemctl restart sshd
        echo "SSHD restarted successfully"
else
        echo "Updating the value for X11Forwarding"
        value=`cat /etc/ssh/sshd_config | grep -v "^#" | grep -i X11Forwarding | awk '{print $NF}'`
        /bin/sed -i 's/X11Forwarding '"$value"'/X11Forwarding no/g' /etc/ssh/sshd_config
        echo "value has been updated successfully. Restarting SSHD"
        /bin/systemctl restart sshd
        echo "SSHD restarted successfully"
fi
