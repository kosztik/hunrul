#!/bin/bash

#
#  Install:
#  copy this script to: /usr/local/bin
#
#



# Variables ##################
##########################


ports=( 2223 25565 )
iface="eth1"
dbhun="/root/hunrul/src/dbhun.txt"
dbexc="/root/hunrul/src/dbexc.txt"

echo "
---------------------------------------------


   iptables HUN rules with exceptions .V3

   Secured ports: ${ports[@]} on $iface

                                       kosztik
----------------------------------------------
"




echo 

# Code ##################
##########################

echo "





"


iptables -F HUN 
#iptables -X HUN
iptables -N HUN
#iptables -I FORWARD 1 -j HUN

file=$dbhun

echo "Inserting rules to HUN chain ... "
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
        #echo "address=/${line}/127.0.0.1"
	echo -n .
	for i in "${ports[@]}"
	do
	   :
	    #iptables -A HUN -s $line -d 10.8.0.13 -p tcp --dport $i -j ACCEPT

	    iptables -A HUN -i $iface -s $line -p tcp --dport $i -j ACCEPT 
	done	
	
done < "$file"
echo -n " done!"
echo ""

file=$dbexc

echo "Inserting exception rules to HUN chain ... "
while read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
        #echo "address=/${line}/127.0.0.1"
	echo -n .
	for i in "${ports[@]}"
	do
	   :
	    #iptables -A HUN -s $line -d 10.8.0.13 -p tcp --dport $i -j ACCEPT

	    iptables -A HUN -i $iface -s $line -p tcp --dport $i -j ACCEPT 
	done	
	
done < "$file"
echo -n " done!"
echo ""


#iptables -A HUN -s 192.168.50.0/24 -d 10.8.0.9 -p tcp --dport 5902 -j ACCEPT
#iptables -A HUN -s 192.168.50.0/24 -d 10.8.0.13 -p tcp --dport 5901 -j ACCEPT

#iptables -A HUN -s 0/0 -d 10.8.0.9 -j LOG --log-prefix "Virtualis gepre 10.8.0.9: "
#iptables -A HUN -s 0/0 -d 10.8.0.13 -j LOG --log-prefix "Virtualis gepre 10.8.0.13: "

# Innen johetnek a tiltasok

for i in "${ports[@]}"
do
	:
	iptables -A HUN -s 0/0 -i $iface -p tcp --dport $i -j DROP
done
