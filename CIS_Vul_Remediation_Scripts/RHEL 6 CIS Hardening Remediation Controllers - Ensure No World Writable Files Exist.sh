#!/bin/bash
#Ensure No World Writable Files Exist#


/bin/echo "Taking permission structure backup of all world writable file exists"
/bin/ls -l $(flag=0;Partitions=`/bin/df --local -P 2>/dev/null| /bin/awk {'if (NR!=1) print $6'}`; SaveIFS=$IFS; IFS=`/bin/echo -e "\n\b"`; for partition in $Partitions; do file=`/bin/find "$partition" -xdev -type f -perm -0002 2>/dev/null`; if [ -n "$file" ]; then /bin/echo "$file"; flag=1; fi; done; IFS=$SaveIFS;) > /var/tmp/bkp_worldwritablefiles_`date +"%d%m%Y%T"`
/bin/echo "Backup completed successfully and it is located under /var/tmp"
for i in $(flag=0;Partitions=`/bin/df --local -P 2>/dev/null| /bin/awk {'if (NR!=1) print $6'}`; SaveIFS=$IFS; IFS=`/bin/echo -e "\n\b"`; for partition in $Partitions; do file=`/bin/find "$partition" -xdev -type f -perm -0002 2>/dev/null`; if [ -n "$file" ]; then /bin/echo "$file"; flag=1; fi; done; IFS=$SaveIFS;)
do
/bin/chmod o-w $i
done
/bin/echo "Perission has been changed successfully"

