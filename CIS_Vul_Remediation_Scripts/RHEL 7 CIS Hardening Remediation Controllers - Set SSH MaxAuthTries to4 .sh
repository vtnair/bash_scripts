#!/bin/bash
#Verify That ClientAliveInterval Is Set to 300 or Less 


SSHConfFile=/etc/ssh/sshd_config
MAXAuthValue=4

# verify that file is exist and change the value
if [ -f $SSHConfFile ]
then
        /bin/echo "File $SSHConfFile exist"
        CurrentValue=`/bin/cat /etc/ssh/sshd_config | /bin/grep -i MaxAuthTrie | /bin/grep -v ^# | /bin/awk '{print $2}' | wc -l`
        if [ $CurrentValue -eq 0 ]
        then
                /bin/echo "Parameter MaxAuthTries is not in conf file or it is commented."
                /bin/echo "MaxAuthTries 4" >> $SSHConfFile
                /sbin/service sshd restart

        else
                MaxVarieble=`cat /etc/ssh/sshd_config | grep -i MaxAuthTrie | grep -v ^# | uniq | /bin/awk '{print $2}'`
                MaxValue=`cat /etc/ssh/sshd_config | grep -i MaxAuthTrie | grep -v ^# | uniq | /bin/awk '{print $2}' `
                if [ $MaxVarieble -eq 4 ]
                then
                        echo "MaxAuthTries  is already restricted to 4 on server. Nothing to do."
                else
                        /bin/echo "MaxAuthTries need to change from $MaxVarieble to 4."
                        /bin/sed -i 's/MaxAuthTries '"$MaxValue"'/MaxAuthTries 4/g' $SSHConfFile
                        /sbin/service sshd restart
                        /bin/echo "MaxAuthTries  is restricted to 4 on server now."
                fi
        fi
else
        /bin/echo "SSH configuration file $SSHConfFile does not exist."
fi