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
#cf
wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/cf.sh && chmod +x cf.sh && ./cf.sh
#install ssh ovpn
wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
#install v2ray
wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/xray/ins-xray.sh && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh
rm -f /root/ins-xray.sh
rm -f /root/cf.sh
rm -f /root/ssh-vpn.sh
systemctl daemon-reload
history -c
echo " "
echo "Installation has been completed!!"echo " "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;41m      🔰 SETUP mantapv2 SLXRAY 🔰      \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" 
echo " 🔰 >>> Service & Port" |tee -a log-install.txt
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
