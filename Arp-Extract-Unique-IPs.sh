#!/bin/bash
#arp-scan
#arp-scan -qx -l > ~/Desktop/IPs-ARP.txt
MYPATH=/home/Desktop

echo "Running ARP-Scan"

sudo arp-scan -qx -l > $MYPATH/IPs-ARP.txt

echo "ARP-SCAN done"

#display IPs from ARP-scan
echo "IPs from ARP-Scan"
#cat $MYPATH/IPs-ARP.txt
cat $MYPATH/IPs-ARP.txt 

#check the file exist in the directory
#FILE=~/Desktop/IPs-ARP.txt
FILE=$MYPATH/IPs-ARP.txt
echo $FILE

if [ -f "$FILE" ];
then

    #extract IPs
    grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $MYPATH/IPs-ARP.txt > $MYPATH/IPs-list.txt
    echo "Extracting IP list"
    #cat $MYPATH/IPs-list.txt
    
    #remove duplicates
    awk ' {print $1 }' $MYPATH/IPs-list.txt | uniq > $MYPATH/Unique-IPs-list.txt
    echo "Unique IP list"
    cat $MYPATH/unique-IPs-list.txt
    echo "***Output saved in /home/Desktop/Unique-IPs-list.txt***"

    #get more info from IPs which are up
    echo "Getting OS Fingerprinting Information from the above IPs"

else
    echo "something went wrong"
fi

