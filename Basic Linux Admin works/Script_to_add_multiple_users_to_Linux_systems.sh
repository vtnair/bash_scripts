#!/bin/bash
# Script to add multiple users to Linux systems

echo "Please ensure the server/IP list added in /tmp/server_to_adduser"
echo "Please ensure the userid list added in /tmp/userlist_to_add"

sleep 2

if [ -f /tmp/server_to_adduser ]
then
        if [ -f /tmp/userlist_to_add ]
        then
                for i in `cat /tmp/server_to_adduser`
                do
                        scp /tmp/Script_to_add_multiple_users_to_Linux_systems.sh /tmp/userlist_to_add root@$i:/tmp/
                        ssh -o StrictHostKeyChecking=no root@$i bash /tmp/Script_to_add_multiple_users_to_Linux_systems.sh
                done
        else
                echo "Userlist file is missing"
        fi
        else
                echo "Server/IP file is missing"
fi
