#!/bin/bash
##Enable IPtables##

/sbin/service iptables status | grep -i "firewall is not running" &> /dev/null

if [[ "$?" == 0 ]];
	then
		/bin/echo "Starting Iptables"	
		/sbin/service iptables start
		if [[ "$?" == 0 ]];
			then
				/bin/echo "Iptables started successfully"
				/sbin/chkconfig iptables on
				/bin/echo "Iptables enabled on chkconfig"
			else
				/bin/echo "Found some issue with Iptables while starting, kinldy start it manually"
		fi	
	else
		/bin/echo "Iptables running on the server, no action required..."
			
fi

		

		


		
