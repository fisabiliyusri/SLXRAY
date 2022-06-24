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
cat > /etc/xray/3vless_h2.json << END
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
#3
#VLESS_WS_NONE
cat > /etc/xray/3vless_ws_none.json << END
{
  "inbounds": [
    {
      "port": 88,
      "protocol": "vless",
      "tag": "vlessWSNONE",
      "settings": {
        "clients": [
          {
            "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
            "email": "vlessWSNONE@XRAYbyRARE"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "tlsSettings": {},
        "tcpSettings": {},
        "kcpSettings": {},
        "httpSettings": {},
        "wsSettings": {
          "path": "/xrayws",
          "headers": {
            "Host": ""
          }
        },
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
#3
#VLESS_WSTLS
cat > /etc/xray/3vless_ws.json << END
{
  "inbounds": [
    {
      "port": 31297,
      "listen": "127.0.0.1",
      "protocol": "vless",
      "tag": "vlessWSTLS",
      "settings": {
        "clients": [
          {
            "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
            "email": "vlessWSTLS@XRAYbyRARE"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/xrayws"
        }
      }
    }
  ]
}

END
#4
#trojan_GRPC_TCP
cat > /etc/xray/4trojan_grpc.json << END
{
    "inbounds": [
        {
            "port": 31304,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "tag": "trojanGRPCTCP",
            "settings": {
                "clients": [
                    {
                        "password": "8bf76417-c1f2-4686-a83c-aec7d0519697",
                        "email": "trojanGRPC@XRAYbyRARE"
                    }
                ],
                "fallbacks": [
                    {
                        "dest": "31300"
                    }
                ]
            },
            "streamSettings": {
                "network": "grpc",
                "grpcSettings": {
                    "serviceName": "xraytrojangrpctcp"
                }
            }
        }
    ]
}

END
#4
#trojan_TCP
cat > /etc/xray/4trojan_tcp.json << END
{
  "inbounds": [
    {
      "port": 31296,
      "listen": "127.0.0.1",
      "protocol": "trojan",
      "tag": "trojanTCP",
      "settings": {
        "clients": [
          {
            "password": "8bf76417-c1f2-4686-a83c-aec7d0519697",
            "email": "trojanTCP@XRAYbyRARE"
          }
        ],
        "fallbacks": [
          {
            "dest": "31300"
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
          "acceptProxyProtocol": true
        }
      }
    }
  ]
}

END
#4
#trojan_XTLS
cat > /etc/xray/4trojan_xtls.json << END
{
    "inbounds": [
        {
            "port": 6443,
            "protocol": "trojan",
            "tag": "trojanXTLS",
            "settings": {
                "clients": [
                    {
                        "password": "8bf76417-c1f2-4686-a83c-aec7d0519697",
                        "flow": "xtls-rprx-direct",
                        "email": "trojanXTLS@XRAYbyRARE"
                    }
                ],
                "fallbacks": [
                    {
                        "alpn": "h2",
                        "dest": 31302,
                        "xver": 0
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
                            "keyFile": "/etc/rare/xray/xray.key"
                        }
                    ]
                },
                "domain": "sgx6b.vless.tech",
                "sniffing": {
                    "enabled": true,
                    "destOverride": [
                        "http",
                        "tls"
                    ]
                }
            }
        }
    ]
}

END
#5
#VMESS_WS_TLS
cat > /etc/xray/5vmess_ws_tls.json << END
{
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 31299,
      "protocol": "vmess",
      "tag": "vmessWSTLS",
      "settings": {
        "clients": [
          {
            "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
            "add": "sgx6b.vless.tech",
            "email": "vmessWSTLS@XRAYbyRARE"            
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/xrayvws"
        }
      }
    }
  ]
}

END
#5
#VMESS_HTTPTLS
cat > /etc/xray/5vmess_http_tls.json << END
{
  "inbounds": [
    {
      "port": 643,
      "protocol": "vmess",
      "tag": "vmessHTTPTLS",
      "settings": {
        "clients": [
            {
                "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
                "email": "vmessHTTPTLS@XRAYbyRARE"                
            }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {
          "header": {
            "type": "http",
            "response": {
              "version": "1.1",
              "status": "200",
              "reason": "OK",
              "headers": {
                "Content-Type": [
                  "application/octet-stream",
                  "video/mpeg",
                  "application/x-msdownload",
                  "text/html",
                  "application/x-shockwave-flash"                  
                ],
                "Transfer-Encoding": [
                  "chunked"
                ],
                "Connection": [
                  "keep-alive"
                ],
                "Pragma": "no-cache"
              }           
            }
          }
        },
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/rare/xray/xray.crt",
              "keyFile": "/etc/rare/xray/xray.key"              
            }
          ],
          "alpn": [
            "h2",
            "http/1.1"
          ]
        }
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
#5
#VMESS_HTTP
cat > /etc/xray/5vmess_http.json << END
{
  "inbounds": [
    {
      "port": 80,
      "protocol": "vmess",
      "tag": "vmessHTTP",
      "settings": {
        "clients": [
            {
                "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
                "email": "vmessHTTP@XRAYbyRARE"                
            }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "tcpSettings": {
          "header": {
            "type": "http",
            "response": {
              "version": "1.1",
              "status": "200",
              "reason": "OK",
              "headers": {
                "Content-Type": [
                  "application/octet-stream",
                  "video/mpeg",
                  "application/x-msdownload",
                  "text/html",
                  "application/x-shockwave-flash"                  
                ],
                "Transfer-Encoding": [
                  "chunked"
                ],
                "Connection": [
                  "keep-alive"
                ],
                "Pragma": "no-cache"
              }           
            }
          }
        },
        "security": "none"
      }
    }
  ]
}

END
#5
#VMESS_TCPTLS
cat > /etc/xray/5vmess_tcp_tls.json << END
{
  "inbounds": [
    {
      "port": 535,
      "protocol": "vmess",
      "tag": "vmessTCPTLS",
      "settings": {
        "clients": [
            {
                "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
                "email": "vmessTCPTLS@XRAYbyRARE"                
            }
        ]
      },
      "streamSettings": {
        "network": "tcp",
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
        },
        "wsSettings": {
            "path": "/xrayvws",
            "headers": {
                "Host": ""
            }
        }
      },
      "domain": "sgx6b.vless.tech",
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
#5
#VMess_WS_NONE
cat > /etc/xray/5vmess_ws_none.json << END
{
  "inbounds": [
    {
      "port": 888,
      "protocol": "vmess",
      "tag": "vmessWSNONE",
      "settings": {
        "clients": [
          {
            "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
            "add": "sgx6b.vless.tech",
            "email": "vmessWSNONE@XRAYbyRARE" 
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "tlsSettings": {},
        "tcpSettings": {},
        "kcpSettings": {},
        "httpSettings": {},
        "wsSettings": {
          "path": "/xrayvws",
          "headers": {
            "Host": ""
          }
        },
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
#5
#VLESS_GRPC
cat > /etc/xray/5vless_grpc.json << END
{
  "inbounds": [
    {
      "port": 6643,
      "protocol": "vless",
      "tag": "vlessGRPC",
      "settings": {
        "clients": [
          {
            "id": "8bf76417-c1f2-4686-a83c-aec7d0519697",
            "add": "sgx6b.vless.tech",
            "email": "vlessGRPC@XRAYbyRARE" 
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "gun",
        "security": "tls",
        "tlsSettings": {
          "serverName": "",
          "alpn": [
            "h2"
          ],
          "certificates": [
            {
              "certificateFile": "/etc/rare/xray/xray.crt",
              "keyFile": "/etc/rare/xray/xray.key"
            }
          ]
        },
        "grpcSettings": {
          "serviceName": "xraygrpc"
        }
      }
    }
  ]
}

END
#7
#shadowsocks
cat > /etc/xray/7shadowsocks.json << END
{
  "inbounds": [
    {
      "port": 1111,
      "protocol": "shadowsocks",
      "tag": "shadowsocksAEAD",
      "settings": {
        "clients": [
            {
              "password": "8bf76417-c1f2-4686-a83c-aec7d0519697",
              "method": "aes-128-gcm",
              "email": "aes-128-gcm@XRAYbyRARE"             
            },
            {
              "password": "8bf76417-c1f2-4686-a83c-aec7d0519697",
              "method": "aes-256-gcm",
              "email": "aes-256-gcm@XRAYbyRARE"                 
            },
            {
              "password": "8bf76417-c1f2-4686-a83c-aec7d0519697",
              "method": "chacha20-poly1305",
              "email": "chacha20-poly1305@XRAYbyRARE"                 
            }
        ],
        "network": "tcp,udp"
      }
    }
  ]
}

END
#10
#ipv4
cat > /etc/xray/10ipv4.json << END
{
    "outbounds":[
        {
            "protocol":"freedom",
            "settings":{
                "domainStrategy":"UseIPv4"
            },
            "tag":"IPv4-out"
        },
        {
            "protocol":"freedom",
            "settings":{
                "domainStrategy":"UseIPv6"
            },
            "tag":"IPv6-out"
        },
        {
            "protocol":"blackhole",
            "settings": {},
            "tag": "blocked"
        },
        {
            "protocol": "freedom",
            "tag": "direct"        
        }
    ],
    "routing": {
        "rules": [
            {
                "type": "field",
                "ip": [
                    "0.0.0.0/8",
                    "10.0.0.0/8",
                    "100.64.0.0/10",
                    "169.254.0.0/16",
                    "172.16.0.0/12",
                    "192.0.0.0/24",
                    "192.0.2.0/24",
                    "192.168.0.0/16",
                    "198.18.0.0/15",
                    "198.51.100.0/24",
                    "203.0.113.0/24",
                    "::1/128",
                    "fc00::/7",
                    "fe80::/10"
                ],
                "outboundTag": "blocked"
            },
            {
                "inboundTag": [
                    "api"
                ],
                "outboundTag": "api",
                "type": "field"
            },
            {
                "type": "field",
                "outboundTag": "blocked",
                "protocol": [
                    "bittorrent"
                ]
            }
        ]
    },
    "stats": {},
    "api": {
        "services": [
            "StatsService"
        ],
        "tag": "api"
    },
    "policy": {
        "levels": {
            "0": {
                "statsUserDownlink": true,
                "statsUserUplink": true
            }
        },
        "system": {
            "statsInboundUplink": true,
            "statsInboundDownlink": true
        }
    }
}

END
#11
#dns
cat > /etc/xray/11dns.json << END
{
    "dns": {
        "servers": [
          "localhost"
        ]
  }
}

END
#CONFIG_SELESAI
#
