#!/bin/bash
##Check for Unconfined Daemons##
Deamons=`ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | awk '{print $1}'`
if [[ "$?" == 0 ]];
        then
		echo "Taking backup of Unconfined Daemons details"
		ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | awk '{print $1 " " $2 " " $NF}'>> /var/tmp/BKP_Daemons_`date +"%d%m%Y%T"`
		echo "Unconfined Daemons details copied successfully and its located under /var/tmp"
        for i in `ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | awk '{print $1}'`;do kill -9 $i;done
		echo "Killed the Unconfined Daemons"
else
        echo "Unconfined Daemons not found"
fi
