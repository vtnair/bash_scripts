# Disable SSH X11 Forwarding
# 
# This script verify That SSH X11 Forwarding Is Disabled
#
# To remediate failure of this policy test, configure the SSH server to disable X11 Forwarding.
#
#
# Initialize Variables
SSHConfFile=/etc/ssh/sshd_config
FWDValue=no

# verify that file is exist and change the value
if [ -f $SSHConfFile ]
then
        /bin/echo "File $SSHConfFile exist"
        CurrentValue=`/bin/cat /etc/ssh/sshd_config | /bin/grep X11Forwarding | /bin/grep -v ^# | /bin/awk '{print $2}' | wc -l`
        if [ $CurrentValue -eq 0 ]
        then
                /bin/echo "Parameter X11Forwarding is not in conf file or it is commented."
                /bin/echo "X11Forwarding no" >> $SSHConfFile
                /sbin/service sshd restart
        else
                X11Variable=`/bin/cat $SSHConfFile | /bin/grep -i X11Forwarding | /bin/grep -v ^# | /bin/awk '{print $2}'`
                if [ $X11Variable -eq no ]
                then
                        echo "X11Forwarding  is already disabled on server. Nothing to do."
                else
                        /bin/echo "Need to change parameter X11Forwarding from yes to no."
                        /bin/sed -i 's/X11Forwarding yes/X11Forwarding no/g' $SSHConfFile
                        /sbin/service sshd restart
                        /bin/echo "X11Forwarding  is disabled on server."
                fi
        fi
else
        /bin/echo "SSH configuration file $SSHConfFile does not exist."
fi