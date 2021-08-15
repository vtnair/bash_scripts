#!/bin/bash
#This script to reset Linux User password through argument values
#The script expect two arguments while calling the script name. 1st argument is user name and 2nd is passord
		grep -e "^$1" /etc/passwd >/dev/null
        if [ $? -eq 0 ]
        then
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $2)
                cp -p /etc/shadow /etc/bkp_shadow_`date`
				sed -i -e  "s,^$1:[^:]\+:,$1:$pass:," /etc/shadow
                [ $? -eq 0 ] && echo "Password has been changed successfully" || echo "Failed to reset the password"
       	fi



