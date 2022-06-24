#!/bin/bash
# mantapv2 slxray
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
clear
domain=$(cat /etc/xray/domain)
#tls="$(cat ~/log-install.txt | grep -w "XRAY SHADOWSOCKS" | cut -d: -f2|sed 's/ //g')"
ss="$(cat ~/log-install.txt | grep -w "XRAY SHADOWSOCKS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${CLIENT_NAME}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
#sed -i '/#vmess-tls$/a\### '"$user $exp"'\
#},{"id": "'""$uuid""'"' /etc/xray/config.json
sed -i '/#xray-ss$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'"' /etc/xray/config.json
cat>/etc/xray/ss-$user.json<<EOF
      {
      "port": 44444,
      "protocol": "shadowsocks",
      "settings": {
        "method": "chacha20-poly1305",
        "password": "${user}",
        #xray-ss
        "network": "tcp,udp"
      }
    },
EOF
#vmess_base641=$( base64 -w 0 <<< $shadowsocks_json)
shadowsocks_base64=$( base64 -w 0 <<< $shadowsocks_json)
#vmess1="vmess://$(base64 -w 0 /etc/xray/ss-$user.json)"
shadowsocks="ss://$(base64 -w 0 /etc/xray/shadowsocks-$user.json)"

systemctl restart xray.service
service cron restart
clear
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m      🔰AKUN SHADOWSOCKS 🔰       \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
#echo -e "Port TLS    : ${tls}"
echo -e "Port SS     : ${ss}"
#echo -e "User ID     : ${uuid}"
#echo -e "Alter ID    : 0"
echo -e "Security    : chacha20-poly1305"
echo -e "Network     : tcp,udp"
echo -e "Password    : ${user}"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link SS     : ${shadowsocks}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
#echo -e "Link No TLS : ${vmess2}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m  🔰Script mantapv2🔰   \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
