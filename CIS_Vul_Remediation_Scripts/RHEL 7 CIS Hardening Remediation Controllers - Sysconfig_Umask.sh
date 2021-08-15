#!/bin/bash
##Set Daemon umask##
echo "Taking backup of sysconfig_init"
cp -p /etc/sysconfig/init /var/tmp/BKP_Set_sysconfig_init_`date +"%d%m%Y%T"`
echo "Sysconfig_init backup completed successfully and its located under /var/tmp"

fvalue=`cat /etc/init.d/functions | grep -v "^#" | grep -i umask | awk '{print $NF}'`
umask_out=`cat /etc/sysconfig/init| grep -v "^#" | grep -i umask`

if [[ "$?" == 1 ]];
        then
        echo "umask $fvalue" >> /etc/sysconfig/init
        echo "Appended umask value"
else
        echo "Updating the value for umask"
        value=`cat /etc/sysconfig/init | grep -v "^#" | grep -i umask | awk '{print $NF}'`
        /bin/sed -i 's/umask '"$value"'/umask '"$fvalue"'/g' /etc/sysconfig/init
        echo "umask value has been updated successfully."
fi
