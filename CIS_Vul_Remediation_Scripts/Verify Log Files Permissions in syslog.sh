#!/bin/bash

##Verify Log Files Permissions in /etc/rsyslog.conf##

echo "Taking backup of current log file structure..."

(ls -l $(/bin/awk -F "#" '$1 !~ /^[[:space:]]*\$/ && $1 !~ /\*[[:space:]]*$/ && $1 !~ /^[[:space:]]*$/{ split($1,a," "); gsub(/-/,"",a[2]); if(a[2] !~ /^@/&& a[2] ~ /^[[:space:]]*\//){ print a[2];} }' /etc/rsyslog.conf 2>/dev/null)) > /var/tmp/syslogperm_`date +"%d%m%Y%T"`

echo "Backup completed successfully and stored under /var/tmp directory.."

for i in $(/bin/awk -F "#" '$1 !~ /^[[:space:]]*\$/ && $1 !~ /\*[[:space:]]*$/ && $1 !~ /^[[:space:]]*$/{ split($1,a," "); gsub(/-/,"",a[2]); if(a[2] !~ /^@/&& a[2] ~ /^[[:space:]]*\//){ print a[2];} }' /etc/rsyslog.conf 2>/dev/null); do chown root:root $i; chmod u-x,og-rwx $i; done

[ $? -eq 0 ] && echo "Owner/Permissions has been changed successfully " || echo "Failed to change Owner/Permissions, Please check manually "