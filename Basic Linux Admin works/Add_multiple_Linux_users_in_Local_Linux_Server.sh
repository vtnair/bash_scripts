#!/bin/bash
#Add multiple Linux users in Local Linux Server
password="password"
for i in `cat /tmp/userlist_to_add`
do
        grep -e "^$i" /etc/passwd >/dev/null
        if [ $? -eq 0 ]
        then
                echo "$i already present in this server `uname -n` "
        else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m -p $pass $i
                [ $? -eq 0 ] && echo "User $i has been added to this server `uname -n` " || echo "Failed to add a user $i in this server `uname -n` "
                chage -d 0 $i
        fi
done
rm -rf /tmp/Add_multiple_Linux_users_in_Local_Linux_Server.sh /tmp/userlist_to_add
