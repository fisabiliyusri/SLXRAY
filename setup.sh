#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
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
echo "Checking VPS"
IZIN=$(wget -qO- ipinfo.io/ip);

rm -f setup.sh
clear
#if [ -f "/etc/v2ray/domain" ]; then
if [ -f "/etc/xray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
mkdir /var/lib/crot;
echo "IP=" >> /var/lib/crot/ipvps.conf
#auto pointingvps
wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/main/ssh/slhost.sh && chmod +x slhost.sh && ./slhost.sh
#install xray
#wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/main/xray/ins-xray.sh && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh
wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/main/xray/sl-xray.sh && chmod +x sl-xray.sh && screen -S xray ./sl-xray.sh
#xtrojan
wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/main/xray/x-trojan.sh && chmod +x x-trojan.sh && screen -S x-trojan ./x-trojan.sh
#install ssh
wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/main/ssh/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
rm -f /root/ins-xray.sh
rm -f /root/sl-xray.sh
rm -f /root/x-trojan.sh
rm -f /root/slhost.sh
rm -f /root/ssh-vpn.sh

systemctl daemon-reload
history -c
echo " "
echo "Installation has been completed!!"echo " "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;41m      🔰 SETUP mantapv2 SLXRAY 🔰      \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" 
echo " 🔰 >>> Service & Port" |tee -a log-install.txt
echo " 🔰  XRAY VLESS XTLS SPLICE  : 443 |tee -a log-install.txt
echo " 🔰  XRAY VLESS XTLS DIRECT  : 443 |tee -a log-install.txt
echo " 🔰  XRAY VLESS WS TLS       : 443 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN TCP         : 443 |tee -a log-install.txt
echo " 🔰  XRAY VMESS TLS          : 443 |tee -a log-install.txt
echo " 🔰  XRAY VLESS GRPC         : 6643 |tee -a log-install.txt
echo " 🔰  XRAY VLESS H2           : 100 |tee -a log-install.txt
echo " 🔰  XRAY VLESS MKCP         : 7443 |tee -a log-install.txt
echo " 🔰  XRAY VLESS MKCP TLS     : 743 |tee -a log-install.txt
echo " 🔰  TROJAN GO               : 2087 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN GRPC TLS    : 653 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN XTLS/TLS    : 6443 |tee -a log-install.txt
echo " 🔰  XRAY VMESS HTTP TLS     : 643 |tee -a log-install.txt
echo " 🔰  XRAY VMESS HTTP         : 80 |tee -a log-install.txt
echo " 🔰  XRAY VMESS TCP TLS      : 535 |tee -a log-install.txt
echo " 🔰  XRAY VLESS WS NONE      : 88 |tee -a log-install.txt
echo " 🔰  XRAY VMESS WS NONE      : 888 |tee -a log-install.txt
echo " 🔰  XRAY Shadowsocks AEAD   : 1111 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN GRPC        : 2083 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN HTTP        : 880 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN XTLS        : 5443 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN WS TLS      : 2096 |tee -a log-install.txt
echo " 🔰  XRAY TROJAN WS NON TLS  : 2095 |tee -a log-install.txt
echo " 🔰 >>> Service & Port" |tee -a log-install.txt
echo " 🔰 YANG BAWAH INI PRODUK CACAT |tee -a log-install.txt
echo " 🔰 VMESS TLS : 2053" |tee -a log-install.txt
echo " 🔰 VMESS NON TLS : 2052" |tee -a log-install.txt
echo " 🔰 VMESS GRPC : 8443" |tee -a log-install.txt
echo " 🔰 VMESS HTTP/2 : 443" |tee -a log-install.txt
echo " 🔰 VLESS XTLS : 99" |tee -a log-install.txt
echo " 🔰 VLESS TLS : 443" |tee -a log-install.txt
echo " 🔰 VLESS NON TLS : 8880" |tee -a log-install.txt
echo " 🔰 VLESS GRPC : 443" |tee -a log-install.txt
echo " 🔰 TROJAN GFW : 4443" |tee -a log-install.txt
echo " 🔰 VLESS HTTP/2 : 443" |tee -a log-install.txt
echo " 🔰 XRAY SOCKS : 999" |tee -a log-install.txt
echo " 🔰 XRAY SHADOWSOCKS : 333" |tee -a log-install.txt
echo " 🔰 XRAY MTPROTO : 111" |tee -a log-install.txt
echo " 🔰 TROJAN GO : 2087" |tee -a log-install.txt
echo " 🔰 TROJAN GRPC : 2083" |tee -a log-install.txt
echo " 🔰 TROJAN HTTP : 880" |tee -a log-install.txt
echo " 🔰 TROJAN XTLS : 5443" |tee -a log-install.txt
echo " 🔰 TROJAN WS TLS : 2096" |tee -a log-install.txt
echo " 🔰 TROJAN WS NON TLS : 2095" |tee -a log-install.txt
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " 🔰>> Server Information & Other Features"                  |tee -a log-install.txt
echo " 🔰 Timezone                : Asia/Jakarta (GMT +7)"        |tee -a log-install.txt
echo " 🔰 Fail2Ban                : [ON]"                         |tee -a log-install.txt
echo " 🔰 Dflate                  : [ON]"                         |tee -a log-install.txt
echo " 🔰 IPtables                : [ON]"                         |tee -a log-install.txt
echo " 🔰 Auto-Reboot             : [ON]"                         |tee -a log-install.txt
echo " 🔰 IPv6                    : [OFF]"                        |tee -a log-install.txt
echo " 🔰 Autoreboot On 05.00 GMT +7"                             |tee -a log-install.txt
echo " 🔰 Autobackup Data"                                        |tee -a log-install.txt
echo " 🔰 Restore Data"                                           |tee -a log-install.txt
echo " 🔰 Auto Delete Expired Account"                            |tee -a log-install.txt
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;41m           🔰 mantapv2 SLXRAY 🔰            \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " 🔰 Installation Log --> /root/log-install.txt"             |tee -a log-install.txt
echo " Reboot 5 Sec"
sleep 5
rm -f setup.sh
reboot
