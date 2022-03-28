#!/bin/bash

#path
MYPATH=/home/Desktop/scripts

#ping scan
nmap -sn 192.168.0.1/16 --exclude 192.168.1.8 -oN $MYPATH/Nmap-sn-hostdiscovery.txt

#display IPs from Ping sweep
echo "IPs from Ping Sweep"
cat $MYPATH/Nmap-sn-hostdiscovery.txt

#check the file exist in the directory
FILE=$MYPATH/Nmap-sn-hostdiscovery.txt
if test -f "$FILE";
then
    #remove first line
    sed '1d' "$FILE" > $MYPATH/test-1.txt
    #cat test.txt
    
    #extract IPs
    grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $MYPATH/test-1.txt > $MYPATH/IPs-list-PingSweep.txt
   
     #sort IPs-list-PingSweep.txt
    #sort -t . -k 1,1 -k 2,2 -k 3,3n -k 4,4 $MYPATH/IPs-list-PingSweep.txt > $MYPATH/sorted-IPs-list-PingSweep.txt   
    sort -t . -k 3,3n -k 4,4n $MYPATH/IPs-list-PingSweep.txt > $MYPATH/sorted-IPs-list-PingSweep.txt
    cat $MYPATH/sorted-IPs-list-PingSweep.txt
   
    #remove duplicates
    awk ' {print $1 }' $MYPATH/sorted-IPs-list-PingSweep.txt | uniq > $MYPATH/Unique-IPs-list-pingsweep.txt
    echo "Extracting Unique IPs list in the LAN\n"
    cat $MYPATH/Unique-IPs-list-pingsweep.txt
    echo "***Output saved in /home/Desktop/scripts/Unique-IPs-list-pingsweep.txt***"

    #get more info from IPs which are up
    echo "Getting OS Fingerprinting Information from the above IPs (UP)\n\n"
    nmap -sT -A -v -iL $MYPATH/Unique-IPs-list-pingsweep.txt -oN $MYPATH/Get_MoreInfo_pingsweep.txt --exclude 192.168.1.7, 192.168.1.8
    echo "***saving OS Fingerprinting Information in /home/Desktop/scripts folder***"

else
    echo "something went wrong"
fi
