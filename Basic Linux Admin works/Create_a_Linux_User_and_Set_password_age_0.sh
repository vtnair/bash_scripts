#!/bin/bash
#This script is to create a User in Linux server with chage set to 0#
password="password"
for i in `cat /tmp/userlist_to_add`
do
        grep -e "^$i" /etc/passwd >/dev/null
        if [ $? -eq 0 ]
        then
                echo "$i already available"
        else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m -p $pass $i
                [ $? -eq 0 ] && echo "User $i has been added to system!" || echo "Failed to add a user $i"
        	chage -d 0 $i
	fi
done
rm -rf Create_a_Linux_User_and_Set_password_age_0.sh /tmp/userlist_to_add