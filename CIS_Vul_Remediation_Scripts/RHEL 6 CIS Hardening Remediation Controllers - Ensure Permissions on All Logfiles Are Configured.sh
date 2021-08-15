#!/bin/bash
#Ensure Permissions on All Logfiles Are Configured#

/bin/echo "Taking Permission structure backup of Log file"
/bin/find /var/log -type f -ls 2>/dev/null | awk '$3 !~ /^-..-.-----$/ {print $3,$5,$6,substr($0,index($0,"/"))}' > /var/tmp/bkp_Logpermission_`date +"%d%m%Y%T"`
/bin/echo "Backup completed successfully and its location under /var/tmp"

for i in `/bin/find /var/log -type f -ls 2>/dev/null | awk '$3 !~ /^-..-.-----$/ {print substr($0,index($0,"/"))}'`
do
	/bin/chmod u-x,g-wx,o-rwx $i
done

/bin/echo "Permission has been changed successfully"