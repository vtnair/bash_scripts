# Create and Set Permissions on rsyslog Log Files
#
# This script verify Log Files Permissions in /etc/rsyslog.conf
#
# To remediate failure of this policy test, set appropriate permissions and ownership on the rsyslog log files.
#
# Setting appropriate permissions and ownership on the rsyslog log files
#
for i in `/bin/cat /etc/rsyslog.conf | /bin/egrep -v '(^\$|^#)' |  /bin/awk '!/^$/' | /bin/awk '{print $2}' | /bin/egrep  ^/`
do
	/bin/chown root:root $i
	/bin/chown u-x,og-rwx $i
done