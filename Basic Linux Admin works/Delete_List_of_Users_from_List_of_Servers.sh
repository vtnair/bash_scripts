#!/bin/bash
# Script to Delete a user From Linux system

echo "Please ensure the server/IP list added in /tmp/server_to_rmuser"
echo "Please ensure the userid list added in /tmp/userlist_to_remove"

sleep 2

if [ -f /tmp/server_to_rmuser ]
then
        if [ -f /tmp/userlist_to_remove ]
        then
                for i in `cat /tmp/server_to_rmuser`
                do
                        scp /tmp/Delete_List_of_Users_from_List_of_Servers.sh /tmp/userlist_to_remove root@$i:/tmp/
                        ssh -o StrictHostKeyChecking=no root@$i bash /tmp/Delete_List_of_Users_from_List_of_Servers.sh
                done
        else
                echo "Userlist file is missing"
        fi
        else
                echo "Server/IP file is missing"
fi