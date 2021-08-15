#!/bin/bash

Users=`/bin/egrep -v "^[[:space:]]*#|^[[:space:]]*$" /etc/passwd 2>/dev/null | /bin/awk -F: '{ cmd = "/usr/bin/passwd -S " $1 " 2>/dev/null"; cmd | getline UserInfo;if ($0 !~ /^[[:space:]]*(#.*|\+.*|root|halt|sync|shutdown):/ &&(UserInfo !~ /^[[:graph:]]+[[:space:]]+LK[[:space:]]+/ || (UserInfo ~ /^[[:space:]]*Unknown[[:space:]]+user\./ && $2 != "!!")) && $7 !~ /^\/sbin\/nologin$/){ print $1 ":"$6}}'`;

if [ ! "$Users" ];
        then
                /bin/echo "There is no enabled local account";
        else
                SavedIFS="$IFS";
                IFS=`/bin/echo -e "\n\b"`;
                for User in $Users;
                do
                UserName=`/bin/echo "$User" | /bin/awk -F: '{print $1}'`;
                HomeDirectory=`/bin/echo "$User" | /bin/awk -F: '{print $2}'`;
                if [ -d "$HomeDirectory" ];
                then
                        DotFiles=`/usr/bin/find "$HomeDirectory" -maxdepth 1 -type f -name "\.[A-Za-z0-9]*" 2>/dev/null`;
                        if [ -n "$DotFiles" ];
                        then
                                echo "Taking backup of the File list and it's permission which going to get modify. Backup will be available under /var/tmp"
                                for file in $DotFiles;
                                do
                                (/bin/ls -alLd "$file" 2>/dev/null | /bin/awk '($1 !~ /^d/ && $1 ~ /(.....|........)w/) { FileName=substr($0,index($0,"/"));print UserName, $1, $3,$4, FileName}' UserName="$UserName";) | tee -a /var/tmp/User_Dot-files_or_grp_world_writable_`date +"%d%m%Y%T"`
                                for i in $(/bin/ls -alLd "$file"  2>/dev/null | /bin/awk '($1 !~ /^d/ && $1 ~ /(.....|........)w/) { FileName=substr($0,index($0,"/"));print FileName}' UserName="$UserName"); do chmod go-w $i; done
                                done;
                        fi;
                fi;
                done;
                IFS="$SavedIFS";
fi;
