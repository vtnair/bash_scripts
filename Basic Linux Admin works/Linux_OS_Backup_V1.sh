#!/bin/bash

if [ -f /root/check-$(hostname)-$(date +%Y%m%d).txt ]; then
clear
echo "OS Check report for $(date +%Y%m%d) is available. Please check /root/check-$(hostname)-$(date +%Y%m%d).txt"
sleep 2
exit 1
else
clear
echo "No OS Check report for $(date +%Y%m%d)... We are proceeding... "
fi
sleep 2 
OS=`cat /etc/redhat-release |sed 's/[^0-9]*//g'| awk '{print substr ($0, 0, 1)}'` >> /dev/null
case ${OS} in
5)
echo "################# Uptime of the server ################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
uptime >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### DNS entry backup ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/resolv.conf >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### Route Configured ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
route -n >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "############## Route details in Conf file #############" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ls -l /etc/sysconfig/network-scripts/route-* 2> /dev/null | awk '{print $9}' > /tmp/routes;for i in `cat routes`; do echo "Route details of" $i;cat ${i}; done >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "############### Default gateway details ###############" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/sysconfig/network  >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################# IP Address details ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ls -l /etc/sysconfig/network-scripts/ifcfg-* 2> /dev/null | awk '{print $9}' > /tmp/interfaces;for i in `cat interfaces`; do echo "Interface details of" $i;cat ${i}; done >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "##################### FSTab entry #####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/fstab >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "#################  Mounted FS details #################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
mount -v >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "#################  mounted FS details #################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
df -hT >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "###################  Memory Details ####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
free -m >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "####################  Swap Details #####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
swapon -s >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "##################  IPTables Details ###################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
iptables -L >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################  IPTables in chkconfig ################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
chkconfig --list | grep -i iptables >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### Selinux details ####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
getenforce >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################## Selinux Conf file ###################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/selinux/config | grep -v '^#' >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "We are done with the OS check and the output will be available at "/root/check-$(hostname)-$(date +%Y%m%d).txt". Copy it to a safe location!!!"
sleep 2
;;
6)
echo "################# Uptime of the server ################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
uptime >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### DNS entry backup ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/resolv.conf >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### Route Configured ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ip route show >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "############## Route details in Conf file #############" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ls -l /etc/sysconfig/network-scripts/route-* 2> /dev/null | awk '{print $9}' > /tmp/routes;for i in `cat routes`; do echo "Route details of" $i;cat ${i}; done >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "############### Default gatewat details ###############" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/sysconfig/network  >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################# IP Address details ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ls -l /etc/sysconfig/network-scripts/ifcfg-* 2> /dev/null | awk '{print $9}' > /tmp/interfaces;for i in `cat interfaces`; do echo "Interface details of" $i;cat ${i}; done >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "##################### FSTab entry #####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/fstab >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "#################  Mounted FS details #################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
mount -v >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "#################  mounted FS details #################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
df -hT >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "###################  Memory Details ####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
free -m >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "####################  Swap Details #####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
swapon -s >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "##################  IPTables Details ###################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
iptables -L >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################  IPTables in chkconfig ################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
chkconfig --list | grep -i iptables >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### Selinux details ####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
getenforce >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################## Selinux Conf file ###################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/selinux/config | grep -v '^#' >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "We are done with the OS check and the output will be available at "/root/check-$(hostname)-$(date +%Y%m%d).txt". Copy it to a safe location!!!"
sleep 2
;;
7)
echo "################# Uptime of the server ################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
uptime >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### DNS entry backup ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/resolv.conf >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### Route Configured ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ip route show >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "############## Route details in Conf file #############" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ls -l /etc/sysconfig/network-scripts/route-* 2> /dev/null | awk '{print $9}' > /tmp/routes;for i in `cat routes`; do echo "Route details of" $i;cat ${i}; done >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "############### Default gatewat details ###############" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/sysconfig/network  >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################# IP Address details ##################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
ls -l /etc/sysconfig/network-scripts/ifcfg-* 2> /dev/null | awk '{print $9}' > /tmp/interfaces;for i in `cat interfaces`; do echo "Interface details of" $i;cat ${i}; done >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "##################### FSTab entry #####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/fstab >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "#################  Mounted FS details #################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
mount -v >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "#################  mounted FS details #################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
df -hT >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "###################  Memory Details ####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
free -m >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "####################  Swap Details #####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
swapon -s >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "##################  IPTables Details ###################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
iptables -L >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################  IPTables in chkconfig ################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
systemctl status firewalld >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################### Selinux details ####################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
getenforce >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "################## Selinux Conf file ###################" >> /root/check-$(hostname)-$(date +%Y%m%d).txt
cat /etc/selinux/config | grep -v '^#' >> /root/check-$(hostname)-$(date +%Y%m%d).txt
echo "We are done with the OS check and the output will be available at "/root/check-$(hostname)-$(date +%Y%m%d).txt". Copy it to a safe location!!!"
sleep 2
;;
*)
echo "Not a Redhat Linux, please go for a manual check."
;;
esac
