#!/bin/bash
# mantapv2 SLXRAY
# =====================================================

# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

MYIP=$(wget -qO- ipinfo.io/ip);
clear
domain=$(cat /etc/xray/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
chronyc sourcestats -v
chronyc tracking -v
date

# / / Ambil Xray Core Version Terbaru
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

# / / Installation Xray Core
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

# / / Make Main Directory
mkdir -p /usr/bin/xray
mkdir -p /etc/xray

# / / Unzip Xray Linux 64
cd `mktemp -d`
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray

# Make Folder XRay
mkdir -p /var/log/xray/

sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cd /root/
wget https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh
bash acme.sh --install
rm acme.sh
cd .acme.sh
bash acme.sh --register-account -m slinfinity69@gmail.com
bash acme.sh --issue --standalone -d $domain --force
bash acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key

uuid=$(cat /proc/sys/kernel/random/uuid)

# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"

# Buat Config Xray
#1
#LOG
cat > /etc/xray/1log.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  }
}

END
#Port UTAMA 443
#2
#VLESS_TCP
cat > /etc/xray/2vless.json << END
{
  "inbounds": [
    {
      "port": 443,
      "protocol": "vless",
      "tag": "vlessTCP",
      "settings": {
        "clients": [
          {
            "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
            "add": "sgx6b.vless.tech",
            "flow": "xtls-rprx-direct",
            "email": "vlessTCP@XRAYbyRARE" 
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 31296,
            "xver": 1
          },
          {
            "alpn": "h2",
            "dest": 31302,
            "xver": 0
          },
          {
            "path": "/xrayws",
            "dest": 31297,
            "xver": 1
          },
          {
            "path": "/xrayvws",
            "dest": 31299,
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "alpn": [
            "http/1.1",
            "h2"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/rare/xray/xray.crt",
              "keyFile": "/etc/rare/xray/xray.key",
              "ocspStapling": 3600,
              "usage": "encipherment"
            }
          ]
        }
      }
    }
  ]
}

END
#3
#VLESS_H2
cat > /etc/xray/3vlessh2.json << END
{
  "inbounds": [
    {
      "port": 100,
      "protocol": "vless",
      "tag": "vlessH2",
      "settings": {
        "clients": [
            {
                "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
                "flow": "xtls-rprx-direct",
                "email": "vlessH2@XRAYbyRARE"                
            }
        ],
        "decryption": "none",
        "fallbacks": [
            {
                "dest": 65534
            }
        ],
        "fallbacks_h2": [
            {
                "dest": 65535 
            }
        ]
      },
      "streamSettings": {
        "network": "h2",
        "httpSettings": {
            "path": "/vlessh2"
        },
        "security": "tls",
        "tlsSettings": {
            "alpn": [
                "h2",
                "http/1.1"
            ],
            "certificates": [
                {
                    "certificateFile": "/etc/rare/xray/xray.crt",
                    "keyFile": "/etc/rare/xray/xray.key"
                }
            ]
        }
      },
      "domain": "sgx6b.vless.tech"
    }
  ]
}

END
#3
#VLESS_MKCPTLS
cat > /etc/xray/3vless_mkcptls.json << END
{
  "inbounds": [
    {
      "port": 743,
      "protocol": "vless",
      "tag": "vlessMKCPwgTLS",
      "settings": {
        "clients": [
            {
              "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
              "flow": "xtls-rprx-direct",
              "email": "vlessMKCPwgTLS@XRAYbyRARE"             
            }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "alpn": "h2",
            "dest": 31302,
            "xver": 0            
          }
        ]
      },
      "streamSettings": {
        "network": "kcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/rare/xray/xray.crt",
              "keyFile": "/etc/rare/xray/xray.key"              
            }
          ]
        },
        "kcpSettings": {
          "mtu": 1350,
          "tti": 50,
          "uplinkCapacity": 100,
          "downlinkCapacity": 100,
          "congestion": false,
          "readBufferSize": 2,
          "writeBufferSize": 2,
          "header": {
            "type": "wireguard"
          },
          "seed": "vlessmkcptls"
        },
        "wsSettings": {},
        "quicSettings": {}
      },
      "domain": "sgx6c.vless.tech",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ]
}

END
#3
#VLESS_MKCP
cat > /etc/xray/3vless_mkcp.json << END
{
  "inbounds": [
    {
      "port": 7443,
      "protocol": "vless",
      "tag": "vlessMKCPwg",
      "settings": {
        "clients": [
            {
              "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
              "flow": "xtls-rprx-direct",
              "email": "vlessMKCPwg@XRAYbyRARE"             
            }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "alpn": "h2",
            "dest": 31302,
            "xver": 0            
          }
        ]
      },
      "streamSettings": {
        "network": "kcp",
        "security": "none",
        "tlsSettings": {},
        "kcpSettings": {
          "mtu": 1350,
          "tti": 50,
          "uplinkCapacity": 100,
          "downlinkCapacity": 100,
          "congestion": false,
          "readBufferSize": 2,
          "writeBufferSize": 2,
          "header": {
            "type": "wireguard"
          },
          "seed": "vlessmkcp"
        },
        "wsSettings": {},
        "quicSettings": {}
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ]
}

END
#
