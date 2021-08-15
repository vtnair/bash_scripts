#!/bin/bash
#This script to remove list of users from Local Linux Machine#
for i in `cat /tmp/userlist_to_remove`
do
        grep -e "^$i" /etc/passwd >/dev/null
        if [ $? -eq 0 ]
        then
                userdel -r $i
                [ $? -eq 0 ] && echo "User $i has been removed from `uname -n` " || echo "Failed to remove the user $i from `uname -n` "

        else
                echo "User $i is not present in the server `uname -m` "
        fi
done
rm -rf Delete_List_of_Users.sh /tmp/userlist_to_remove
