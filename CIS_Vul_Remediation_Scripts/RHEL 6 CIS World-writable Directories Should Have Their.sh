#!/bin/bash
##World-writable Directories Should Have Their Sticky Bit Set##

/bin/echo "Taking backup of World-writable Directories"
(PARTs=`/bin/df --local -P 2>/dev/null | /bin/awk 'NR != 1 {$1="";$2="";$3="";$4="";$5="";gsub("^[[:space:]]+/","/",$0);print $0}' 2>/dev/null`; SaveIFS=$IFS;IFS=`/bin/echo -e "\n\b"`; for PART in $PARTs; do /usr/bin/find "$PART" -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -ls 2>/dev/null | /bin/awk '{a=$3; gsub("^[^/]*/","/",$0); print a, $0}'; done;) > /var/tmp/wwwdir_`date +"%d%m%Y%T"`
echo "Backup completed successfully and it is located under /var/tmp"

echo "Adding sticky bit to all Directories listed!..Please wait..!"
for i in $(PARTs=`/bin/df --local -P 2>/dev/null | /bin/awk 'NR != 1 {$1="";$2="";$3="";$4="";$5="";gsub("^[[:space:]]+/","/",$0);print $0}' 2>/dev/null`; SaveIFS=$IFS;IFS=`/bin/echo -e "\n\b"`; for PART in $PARTs; do /usr/bin/find "$PART" -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -ls 2>/dev/null | /bin/awk '{a=$3; gsub("^[^/]*/","/",$0); print $0}'; done;); do chmod +t $i; done
[ $? -eq 0 ] && echo "Sticky bit added successfully on the server " || echo "Failed to add sticky bit, please check the server manually"