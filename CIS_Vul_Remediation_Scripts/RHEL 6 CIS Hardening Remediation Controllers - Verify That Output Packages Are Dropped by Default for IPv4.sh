#!/bin/bash
##Verify That Output Packages Are Dropped by Default for IPv4##

##Command to drop output package##

/sbin/iptables -P OUTPUT DROP
/sbin/iptables-save > /etc/sysconfig/iptables
if [[ "$?" == 0 ]];
	then 
		/bin/echo "Configured the firewall to drop output policy successfully"
	else	
		/bin/echo "Found some issue while doing the changes, need to check manaully..."
fi



		

		


		
