#!/bin/bash

#Bash menu script
#get IP address from user input
# read IP address

echo " enter ip address: "
read ip_add

echo " you entered this IP: "
echo $ip_add

#path
MYPATH=/home/Desktop/scripts
echo "The directory is: "
echo $MYPATH

echo "Different Firewall Evasion Technique"

#ip_add=$(IP_add)

function ACK-Scan(){
    echo ""
    echo "you choose ACK-Scan - check firewall rule"
    echo "Please check output whether you will get Reset(RST) packet - no filter or something else"
    #ACK Scan
    hping3 -A $ip_add -p 22 -c 50 
    echo "Firewall Status - TCP ACK Scanning; if you want to stop scanning, type Ctrl+X to quit"
}
function FW-Port-Detection(){
    echo ""
    echo "you choose Nmap Firewall - Port Status from the Firewall "
    nmap -sA $ip_add -v -oN /home/Desktop/scripts/FW-Port-Detection.txt
    echo " the output file is saved under Desktop/scripts/"
}

function Decoy-IP(){
    echo ""
    echo "you choose Decoy IP address - if they have IP filtering"
    echo "Enter (Decoy) source IP address"
    read sp_ip 
    nmap -D $sp_ip $ip_add
}

function Source-Port(){
    echo ""
    echo "you choose - Source Port changes - checking misconfiguration of Firewall"
    echo "Common ports you can use: 20, 53, and 67"
    echo "Enter one port from above"
    read port_num
    nmap --source-port $port_num $ip_add
}
function Data-Length(){
    echo ""
    echo "you choose Data Length - increase package size by adding 25 bytes more"
    echo "Many Firewalls are inspecting packets by looking at their size to identify a potential port scan"
    nmap --data-length 25 $ip_add
}


##
# Color Variables
##
green='\e[32m'
blue='\e[34m'
#clear='\e[0m"

##
# Color Functions

##

ColorGreen(){
    echo -ne $green$1$clear
}

ColorBlue(){
    echo -ne $blue$1$clear
}

menu(){

    echo -ne "
    Choose Option Menu
    $(ColorGreen '1)') ACK-Scan
    $(ColorGreen '2)') FW-Port-Detection   
    $(ColorGreen '3)') Decoy-IP
    $(ColorGreen '4)') Source-Port
    $(ColorGreen '5)') Data-Length
    $(ColorGreen '0)') Exit
    $(ColorBlue 'Choose an option:')"

    read a
    case $a in
        1) ACK-Scan ; menu ;;
	2) FW-Port-Detection ; menu ;;
	3) Decoy-IP ; menu ;;
	4) Source-Port ; menu;;
	5) Data-Length ; menu;;
        0) exit 0 ;;
    *) echo -e $red"Wrong option."$clear;WrongCommand;;
    esac
}

#Call the menu function
menu

#fi
