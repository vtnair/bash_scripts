#!/bin/bash
##Verify That net.ipv4.conf.all.secure_redirects Is Equal to 0##

##Taking backup of /etc/sysctl.conf file##
cp -p /etc/sysctl.conf /var/tmp/bkp_sysctl.conf_`date +"%d%m%Y%T"`

/bin/echo "Backup completed successfully and copy available at /tmp/var Dir"

cat /etc/sysctl.conf | grep -v "^#" | grep -i net.ipv4.conf.all.secure_redirects &> /dev/null

if [[ "$?" == 1 ]];
	then
		/bin/echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
		sysctl -p &> /dev/null
		if [[ "$?" == 0 ]];
			then	
				/bin/echo "Parameter has been added successfully"
			else
				/bin/echo "Found some issue while performing task, kinldy check this manually.."
		fi
	else
		value=`cat /etc/sysctl.conf | grep -v "^#"| grep -i "net.ipv4.conf.all.secure_redirects" | awk -F= '{print $2}' | tr -d " "`  
		if [[ $value == 0 ]];
			then	
				/bin/echo "Settings are correct, no action required..Exting.."
			else
				/bin/echo "Changing the parameter value to 0"
				/bin/sed -i 's/net.ipv4.conf.all.secure_redirects = '"$value"'/net.ipv4.conf.all.secure_redirects = 0/g' /etc/sysctl.conf
				/bin/echo "Value has been added successully"
		fi
fi		




		
        