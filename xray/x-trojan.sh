#!/bin/bash
# mantapv2 slxray
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
domain=$(cat /root/domain)
apt install iptables iptables-persistent -y

# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"
#
uuid=$(cat /proc/sys/kernel/random/uuid)
cat > /etc/xray/xtrojan.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 5443,
      "protocol": "trojan",
      "tag": "TROJAN-xtls-in",
      "settings": {
        "clients": [
          {
            "password": "${uuid}",
            "flow": "xtls-rprx-direct",
            "level": 0
#trojan-xtls
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 2083,
            "xver": 0
          },
          {
            "path": "/slxray",
            "dest": 2096,
            "xver": 0
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "alpn": [
            "h2",
            "http/1.1"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ]
        }
      }
    },
    {
      "port": 2083,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "TROJAN-gRPC-in",
      "settings": {
        "clients": [
          {
            "password": "${uuid}",
#trojan-grpc
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "grpc",
        "grpcSettings": {
          "serviceName": "slxray"
        }
      }
    },
    {
      "port": 2096,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "TROJAN-WSTLS-in",
      "settings": {
        "clients": [
          {
            "password": "${uuid}",
#trojan-tls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/slxray"
        }
      }
    },
    {
      "port": 2095,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "TROJAN-WS-in",
      "settings": {
        "clients": [
          {
            "password": "${uuid}",
#trojan-nontls
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/slxray"
        }
      }
    },
    {
      "port": 880,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "TROJAN-HTTP-in",
      "settings": {
        "clients": [
          {
            "password": "${uuid}",
#trojan-http
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
         "header": {
          "type": "http",
           "response": {
            "version": "1.1",
             "status": "200",
             "reason": "OK",
             "headers": {}
            }
          }
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "tag": "blocked"
    }
  ],
  "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4",
      "1.1.1.1",
      "1.0.0.1",
      "localhost",
      "https+local://dns.google/dns-query",
      "https+local://1.1.1.1/dns-query"
    ]
  },
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "TROJAN-XTLS-in",
          "TROJAN-gRPC-in",
          "TROJAN-WSTLS-in",
          "TROJAN-WS-in",
          "TROJAN-HTTP-in"
        ],
        "outboundTag": "direct"
      }
    ]
  }
}
END

# / / Installation XTrojan Service
cat > /etc/systemd/system/xtrojan.service << END
[Unit]
Description=XTROJAN slxray
Documentation=https://nekopoi.care
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/xtrojan.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END


# // Enable & Start Service
# Accept port Xray

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2083 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2083 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2096 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2095 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2095 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2096 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 880 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

##restart&start service
systemctl daemon-reload
systemctl stop xtrojan.service
systemctl start xtrojan.service
systemctl enable xtrojan.service
systemctl restart xtrojan.service

cd
cp /root/domain /etc/xray
