#!/bin/bash
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
# ==================================================
# Link Hosting Kalian
slxray1="raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh"

# Link Hosting Kalian Untuk Xray
slxray1n="raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/xray"

# Link Hosting Kalian Untuk Trojan Go
slxray1nn="raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/trojango"

# Link Hosting Kalian Untuk Stunnel5
slxray1nnn="raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/stunnel5"

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=US
state=California
locality=San-Fransisco
organization=Cloudflare
organizationalunit=www.cloudflare.com
commonname=Cloudflare-Inc.
email=sulaiman.xl@facebook.com

# simple password minimal
wget -O /etc/pam.d/common-password "https://${slxray1}/password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
END


# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
apt-get purge apache2* -y
rm -rf /etc/apache2

# install wget and curl
apt -y install wget curl

# Install Requirements Tools
apt install ruby -y
apt install python -y
apt install make -y
apt install cowsay -y
apt install figlet -y
apt install lolcat -y
apt install cmake -y
apt install ncurses-utils -y
apt install coreutils -y
apt install rsyslog -y
apt install net-tools -y
apt install zip -y
apt install unzip -y
apt install nano -y
apt install sed -y
apt install gnupg -y
apt install gnupg1 -y
apt install bc -y
apt install jq -y
apt install apt-transport-https -y
apt install build-essential -y
apt install dirmngr -y
apt install libxml-parser-perl -y
apt install neofetch -y
apt install git -y
apt install lsof -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install gcc -y
apt install g++ -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl-dev -y
apt install libssl1.0-dev -y
gem install lolcat
apt install jq curl -y
apt install dnsutils jq -y
apt-get install net-tools -y
apt-get install tcpdump -y
apt-get install dsniff -y
apt install grepcidr -y

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
mkdir /etc/ssl/mantapxsl.my.id/

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof
#echo "neofetch" >> .profile
echo "status" >> .profile


# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://${slxray1}/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500' /etc/rc.local

make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 3650 \
-subj "/C=US/ST=California/L=San-Fransisco/O=Cloudflare-Inc./OU=www.cloudflare.com/CN=Cloudflare/email=slinfinity69@gmail.com"
cat key.pem cert.pem >> /etc/stunnel5/stunnel5.pem

# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i 's/Port 2525/g' /etc/ssh/sshd_config

# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=200/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 300"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid
cd
#apt -y install squid3
#wget -O /etc/squid/squid.conf "https://${slxray1}/squid3.conf"
#sed -i $MYIP2 /etc/squid/squid.conf

# Install SSLH
apt -y install sslh
rm -f /etc/default/sslh
# Settings SSLH
cat > /etc/default/sslh <<-END
# Default options for sslh initscript
# sourced by /etc/init.d/sslh

# Disabled by default, to force yourself
# to read the configuration:
# - /usr/share/doc/sslh/README.Debian (quick start)
# - /usr/share/doc/sslh/README, at "Configuration" section
# - sslh(8) via "man sslh" for more configuration details.
# Once configuration ready, you *must* set RUN to yes here
# and try to start sslh (standalone mode only)

RUN=yes

# binary to use: forked (sslh) or single-thread (sslh-select) version
# systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh

DAEMON_OPTS="--user sslh --listen 0.0.0.0:70 --ssl 127.0.0.1:500 --ssh 127.0.0.1:300 --openvpn 127.0.0.1:1194 --http 127.0.0.1:80 --pidfile /var/run/sslh/sslh.pid -n"

END
# Service SSLH systemctl restart sslh
#cat > /lib/systemd/system/sslh.service << END
[Unit]
Description=SSH MULTIPLEXLER XRAY
After=network.target
Documentation=http://internet.com

[Service]
EnvironmentFile=/etc/default/sslh
ExecStart=/usr/sbin/sslh --foreground $DAEMON_OPTS
KillMode=process

[Install]
WantedBy=multi-user.target
END

# Restart Service SSLH
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status
/etc/init.d/sslh restart

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

# install stunnel 5 
cd /root/
wget -q -O stunnel5.zip "https://${slxray1nnn}/stunnel5.zip"
unzip -o stunnel5.zip
cd /root/stunnel
chmod +x configure
./configure
make
make install
cd /root
rm -r -f stunnel
rm -f stunnel5.zip
mkdir -p /etc/stunnel5
chmod 644 /etc/stunnel5

# Download Config Stunnel5
cat > /etc/stunnel5/stunnel5.conf <<-END
cert= /etc/xray/xray.crt
key= /etc/xray/xray.key
#cert= /etc/stunnel5/stunel5.pem

client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 600
connect = 127.0.0.1:200

[dropbear]
accept = 700
connect = 127.0.0.1:300

[openssh]
accept = 800
connect = 127.0.0.1:22

[openssh]
accept = 500
connect = 127.0.0.1:70

[openvpn]
accept = 990
connect = 127.0.0.1:1194

END

make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 3650 \
-subj "/C=ID/ST=Indonesia/L=Bumi/O=XRAY/OU=XRAY/CN=localhost/email=sulaiman.xl@facebook.com"
cat key.pem cert.pem >> /etc/stunnel5/stunnel5.pem

# Service Stunnel5 systemctl restart stunnel5
cat > /etc/systemd/system/stunnel5.service << END
[Unit]
Description=STUNNEL5 XRAY
Documentation=https://stunnel5.org
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/bin/stunnel5 /etc/stunnel5/stunnel5.conf
Type=forking

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
wget -q -O /etc/init.d/stunnel5 "https://${slxray1nnn}/stunnel5.init"

# Ubah Izin Akses
chmod 600 /etc/stunnel5/stunnel5.pem
chmod +x /etc/init.d/stunnel5
cp /usr/local/bin/stunnel /usr/local/bin/stunnel5

# Remove File
rm -r -f /usr/local/share/doc/stunnel/
rm -r -f /usr/local/etc/stunnel/
rm -f /usr/local/bin/stunnel
#rm -f /usr/local/bin/stunnel3
rm -f /usr/local/bin/stunnel4
#rm -f /usr/local/bin/stunnel5

# Restart Stunnel 5
systemctl stop stunnel5
systemctl enable stunnel5
systemctl start stunnel5
systemctl restart stunnel5
/etc/init.d/stunnel5 restart
/etc/init.d/stunnel5 status
/etc/init.d/stunnel5 restart

#OpenVPN
#wget https://${slxray1}/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# banner /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# Install BBR
#wget https://${slxray1}/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# Ganti Banner
wget -O /etc/issue.net "https://${slxray1}/issue.net"

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# download script
cd /usr/bin
wget -O addhost "https://${slxray1}/addhost.sh"
wget -O about "https://${slxray1}/about.sh"
wget -O menu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/menu.sh"
wget -O addssh "https://${slxray1}/addssh.sh"
wget -O trialssh "https://${slxray1}/trialssh.sh"
wget -O menuu "https://${slxray1}/menuu.sh"
wget -O delssh "https://${slxray1}/delssh.sh"
wget -O member "https://${slxray1}/member.sh"
wget -O delexp "https://${slxray1}/delexp.sh"
wget -O cekssh "https://${slxray1}/cekssh.sh"
wget -O restart "https://${slxray1}/restart.sh"
wget -O speedtest "https://${slxray1}/speedtest_cli.py"
wget -O info "https://${slxray1}/info.sh"
wget -O ram "https://${slxray1}/ram.sh"
wget -O renewssh "https://${slxray1}/renewssh.sh"
wget -O autokill "https://${slxray1}/autokill.sh"
wget -O ceklim "https://${slxray1}/ceklim.sh"
wget -O tendang "https://${slxray1}/tendang.sh"
wget -O clearlog "https://${slxray1}/clearlog.sh"
wget -O changeport "https://${slxray1}/changeport.sh"
wget -O portovpn "https://${slxray1}/portovpn.sh"
wget -O portwg "https://${slxray1}/portwg.sh"
wget -O porttrojan "https://${slxray1}/porttrojan.sh"
wget -O porttrojango "https://${slxray1}/porttrojango.sh"
wget -O portgrpc "https://${slxray1}/portgrpc.sh"
wget -O portsstp "https://${slxray1}/portsstp.sh"
wget -O portsquid "https://${slxray1}/portsquid.sh"
wget -O portvlm "https://${slxray1}/portvlm.sh"
wget -O wbmn "https://${slxray1}/webmin.sh"
wget -O xp "https://${slxray1}/xp.sh"
wget -O swapkvm "https://${slxray1}/swapkvm.sh"
wget -O addvmess "https://${slxray1n}/addvmess.sh"
wget -O addvmessgrpc "https://${slxray1n}/addvmessgrpc.sh"
wget -O addvmesshdua "https://${slxray1n}/addvmesshdua.sh"
wget -O addvmesshttp "https://${slxray1n}/addvmesshttp.sh"
wget -O addvlessxtls "https://${slxray1n}/addvlessxtls.sh"
wget -O addvlesshttp "https://${slxray1n}/addvlesshttp.sh"
wget -O addvlesshdua "https://${slxray1n}/addvlesshdua.sh"
wget -O addxrayss "https://${slxray1n}/addxrayss.sh"
wget -O addvless "https://${slxray1n}/addvless.sh"
wget -O addvlessgrpc "https://${slxray1n}/addvlessgrpc.sh"
wget -O addtrojan "https://${slxray1n}/addtrojan.sh"
wget -O addtrojanxtls "https://${slxray1n}/addtrojan.sh"
wget -O addtrojangrpc "https://${slxray1n}/addtrojanxtls.sh"
wget -O addtrojanwss "https://${slxray1n}/addtrojanwss.sh"
wget -O addtrojanhttp "https://${slxray1n}/addtrojanhttp.sh"
wget -O delvmess "https://${slxray1n}/delvmess.sh"
wget -O delvmessgrpc "https://${slxray1n}/delvmessgrpc.sh"
wget -O delvmesshdua "https://${slxray1n}/delvmesshdua.sh"
wget -O delvmesshttp "https://${slxray1n}/delvmesshttp.sh"
wget -O delvlessxtls "https://${slxray1n}/delvlessxtls.sh"
wget -O delvlesshttp "https://${slxray1n}/delvlesshttp.sh"
wget -O delvlesshdua "https://${slxray1n}/delvlesshdua.sh"
wget -O delxrayss "https://${slxray1n}/delxrayss.sh"
wget -O delvless "https://${slxray1n}/delvless.sh"
wget -O delvlessgrpc "https://${slxray1n}/delvlessgrpc.sh"
wget -O deltrojan "https://${slxray1n}/deltrojan.sh"
wget -O deltrojxtls "https://${slxray1n}/deltrojanxtls.sh"
wget -O deltrojangrpc "https://${slxray1n}/deltrojangrpc.sh"
wget -O deltrojanwss "https://${slxray1n}/deltrojanwss.sh"
wget -O deltrojanhttp "https://${slxray1n}/deltrojanhttp.sh"
wget -O cekvmess "https://${slxray1n}/cekvmess.sh"
wget -O cekvmessgrpc "https://${slxray1n}/cekvmessgrpc.sh"
wget -O cekvmesshdua "https://${slxray1n}/cekvmesshdua.sh"
wget -O cekvmesshttp "https://${slxray1n}/cekvmesshttp.sh"
wget -O cekvlessxtls "https://${slxray1n}/cekvlessxtls.sh"
wget -O cekvlesshttp "https://${slxray1n}/cekvlesshttp.sh"
wget -O cekvlesshdua "https://${slxray1n}/cekvlesshdua.sh"
wget -O cekxrayss "https://${slxray1n}/cekxrayss.sh"
wget -O cekvless "https://${slxray1n}/cekvless.sh"
wget -O cekvlessgrpc "https://${slxray1n}/cekvlessgrpc.sh"
wget -O cektrojan "https://${slxray1n}/cektrojan.sh"
wget -O cektrojanxtls "https://${slxray1n}/cektrojanxtls.sh"
wget -O cektrojangrpc "https://${slxray1n}/cektrojangrpc.sh"
wget -O cektrojanwss "https://${slxray1n}/cektrojanwss.sh"
wget -O cektrojanhttp "https://${slxray1n}/cektrojanhttp.sh"
wget -O renewvmess "https://${slxray1n}/renewvmess.sh"
wget -O renewvmessgrpc "https://${slxray1n}/renewvmessgrpc.sh"
wget -O renewvmesshdua "https://${slxray1n}/renewvmesshdua.sh"
wget -O renewvmesshttp "https://${slxray1n}/renewvmesshttp.sh"
wget -O renewvlessxtls "https://${slxray1n}/renewvlessxtls.sh"
wget -O renewvlesshttp "https://${slxray1n}/renewvlesshttp.sh"
wget -O renewvlesshdua "https://${slxray1n}/renewvlesshdua.sh"
wget -O renewxrayss "https://${slxray1n}/renewxrayss.sh"
wget -O renewvless "https://${slxray1n}/renewvless.sh"
wget -O renewvlessgrpc "https://${slxray1n}/renewvlessgrpc.sh"
wget -O renewtrojan "https://${slxray1n}/renewtrojan.sh"
wget -O renewtrojanxtls "https://${slxray1n}/renewtrojanxtls.sh"
wget -O renewtrojangrpc "https://${slxray1n}/renewtrojangrpc.sh"
wget -O renewtrojanwss "https://${slxray1n}/renewtrojanwss.sh"
wget -O renewtrojanhttp "https://${slxray1n}/renewtrojanhttp.sh"
wget -O certv2ray "https://${slxray1n}/certv2ray.sh"
wget -O addtrgo "https://${slxray1n}/addtrgo.sh"
wget -O deltrgo "https://${slxray1n}/deltrgo.sh"
wget -O renewtrgo "https://${slxray1n}/renewtrgo.sh"
wget -O cektrgo "https://${slxray1n}/cektrgo.sh"
wget -O portsshnontls "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/portsshnontls.sh"
wget -O portsshwstls "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/portsshwstls.sh"
wget -O status "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/status.sh"
wget -O restart "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/restart.sh"
wget -O portdropbear "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/portdropbear.sh"
wget -O portopenssh "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/portopenssh.sh"
wget -O portstunnel5 "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/ssh/portstunnel5.sh"

wget -O trpcwsmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/trpcwsmenu.sh"
wget -O sshovpn "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/sshovpn.sh"
#wget -O l2tpmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/l2tpmenu.sh"
wget -O l2tppmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/l2tppmenu.sh"
#wget -O pptpmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/pptpmenu.sh"
#wget -O sstpmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/sstpmenu.sh"
wget -O wgmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/wgmenu.sh"
wget -O ssmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/ssmenu.sh"
#wget -O ssrmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/ssrmenu.sh"
wget -O vmessmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/vmessmenu.sh"
wget -O vlessmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/vlessmenu.sh"
#wget -O grpcmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/grpcmenu.sh"
wget -O trghmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/trghmenu.sh"
wget -O trxtmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/trxtmenu.sh"
wget -O setmenu "https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/master/update/setmenu.sh"

chmod +x restart
chmod +x portdropbear
chmod +x portopenssh
chmod +x portstunnel5
chmod +x status
chmod +x portsshnontls
chmod +x portsshwstls
chmod +x menuu
chmod +x sshovpn
#chmod +x l2tpmenu
chmod +x l2tppmenu
#chmod +x pptpmenu
#chmod +x sstpmenu
chmod +x wgmenu
chmod +x ssmenu

#chmod +x ssrmenu
chmod +x vmessmenu
chmod +x vlessmenu
#chmod +x grpcmenu
chmod +x trxtmenu
chmod +x trpcwsmenu
chmod +x setmenu
chmod +x trghmenu
chmod +x addhost
chmod +x menu
chmod +x addssh
chmod +x trialssh
chmod +x delssh
chmod +x member
chmod +x delexp
chmod +x cekssh
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renewssh
chmod +x clearlog

chmod +x changeport
chmod +x portovpn
chmod +x portwg
chmod +x porttrojan
chmod +x porttrojango
chmod +x portgrpc
chmod +x portsstp
chmod +x portsquid
chmod +x portvlm

chmod +x wbmn
chmod +x xp
chmod +x swapkvm
chmod +x addvmess
chmod +x addvmessgrpc
chmod +x addvmesshdua
chmod +x addvmesshttp
chmod +x addvless
chmod +x addvlessgrpc
chmod +x addtrojan
chmod +x addvlesshttp
chmod +x addvlesshdua
chmod +x addvlessxtls
chmod +x addxrayss
chmod +x addtrojanxtls
chmod +x addtrojangrpc
chmod +x addtrojanwss
chmod +x addtrojanhttp

chmod +x delvmess
chmod +x delvmessgrpc
chmod +x delvmesshdua
chmod +x delvmesshttp
chmod +x delvless
chmod +x delvlessgrpc
chmod +x delvlessxtls
chmod +x delxrayss
chmod +x deltrojan
chmod +x delvlesshttp
chmod +x delvlesshdua
chmod +x deltrojanxtls
chmod +x deltrojangrpc
chmod +x deltrojanwss
chmod +x deltrojanhttp

chmod +x renewvmess
chmod +x renewvmessgrpc
chmod +x renewvmesshdua
chmod +x renewvmesshttp
chmod +x renewvless
chmod +x renewvlesshdua
chmod +x renewvlessgrpc
chmod +x renewvlessxtls
chmod +x renewxrayss
chmod +x renewtrojan
chmod +x renewvlesshttp
chmod +x renewtrojanxtls
chmod +x renewtrojangrpc
chmod +x renewtrojanwss
chmod +x renewtrojanhttp

chmod +x cekvmesshdua
chmod +x cekvmesshttp
chmod +x cekvlesshttp
chmod +x cekvlesshdua
chmod +x cekvmess
chmod +x cekvmessgrpc
chmod +x cekvless
chmod +x cekvlessgrpc
chmod +x cekvlessxtls
chmod +x cekxrayss
chmod +x cektrojanxtls
chmod +x cektrojangrpc
chmod +x cektrojanwss
chmod +x cektrojanhttp
chmod +x cektrojan

chmod +x certv2ray
chmod +x addtrgo
chmod +x deltrgo
chmod +x renewtrgo
chmod +x cektrgo

# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/vnstat restart
#/etc/init.d/fail2ban restart
#/etc/init.d/squid restart

screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
echo "0 5 * * * root clearlog && reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh

# finishing
clear
