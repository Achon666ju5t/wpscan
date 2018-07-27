#!/bin/bash
#CMS Scanner
#thank's to IndoXploit - Extreme Crew
# create function

cyan='\033[0;36m'
kuning='\033[1;33m'
putih='\033[0m'
ijo='\e[38;5;82m'
merah='\e[38;5;196m'
 header(){
printf "${ijo}"
printf "   _____         .__                    ________ ________ ________    __      .________ __    \n"
printf "  /  _  \   ____ |  |__   ____   ____  /  _____//  _____//  _____/   |__|__ __|   ____//  |_  \n"
printf " /  /_\  \_/ ___\|  |  \ /  _ \ /    \/   __  \/   __  \/   __  \    |  |  |  \____  \/   __\ \n"
printf "/    |    \  \___|   Y  (  <_> )   |  \  |__\  \  |__\  \  |__\  \   |  |  |  /       \|  |   \n"
printf "\____|__  /\___  >___|  /\____/|___|  /\_____  /\_____  /\_____  /\__|  |____/______  /|__|   \n"
printf "        \/     \/     \/            \/       \/       \/       \/\______|           \/        \n"
printf "${putih}\n"
}
tarik(){
	target=$1
	# path=$(cat $(pwd)/list.txt)
	# tentupath=$(echo "$2" | gawk -F/ '{ print $3}')
	# ecokeun="Achon666ju5t"
	printf "${kuning}"
	echo "========================================"
	printf "%-15s : $1\n" 			"Target "
	webserver=$(curl -sI $target | grep -i server | gawk -F: '{ print $2 }')
	printf "%-15s :$webserver\n" 	"Webserver "
	versiphp=$(curl -sI $target | grep -i powered-by | gawk -F: '{ print $2} ')
	printf "%-15s :$versiphp\n"		"PHP Version "
	getip=$(host $target | gawk '{ print $4 }' | head -1)
	printf "%-15s : $getip\n" 		"Target IP "
	themescek=$(curl -s $target | grep -Po "(?<=$target\/wp-content/themes/).*?(?=/)" | head -1)
	printf "%-15s : $themescek\n" 	"Themes"
	ambilplugin=$(curl -s $target | grep -Po "(?<=$target/wp-content/plugins/).*?(?=/)" | sort | uniq )
	cekplugin=$(curl -s $target | grep -Po "(?<=$target/wp-content/plugins/).*?(?=/)" | sort | uniq | wc -l)
	if [[ "$cekplugin" > "1" ]]; then
		for i in $ambilplugin; do
			printf "%-15s : $i\n" "Plugins"
		done
	else
		printf "%-15s : $i\n" "Plugins"
	fi
	printf "%-15s : "				"Exploit link "
	printf "https://google.com/search?q=exploit+wp+themes+$themescek\n"
	printf "${cyan}[+] Try Login with user admin and password admin [+]${kuning}\n"
	brute=$(curl -s -X POST --url "$target/wp-login.php" -d "log=admin&pwd=admin&wp-submit=Log+In&redirect_to=$target/wp-admin&testcookie=1" -H "Cookie: wordpress_test_cookie=WP+Cookie+check; et-editor-available-post-66-bb=bb" | grep -Po "(?<=\<strong>).*?(?=\<\/strong>)")
	if [[ "$brute" =~ "admin" ]]; then
		printf "%-15s : admin\n" "User "
	elif [[ "$brute" =~ "ERROR" ]]; then
		printf "%-15s : The user not admin\n" "User | Password"
	else
		printf "%-15s : Admin | admin\n" "User | Password"
	fi
	echo "========================================"
}
#call banner function
clear
header
# end call
while true; do
	printf "${ijo}Your Target : ${putih}"
	read coose
	if [[ "$coose" =~ "http://" || $coose =~ "https://" ]]; then
		printf "${cyan}Put Your target without https:// or http://\n"
		continue;
	else
		tarik $coose
		break;
	fi
done
echo ""
