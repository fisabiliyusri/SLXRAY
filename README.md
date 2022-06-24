# SLXRAY
XRAY MULTI PORT

# INSTALL
```html
rm -f setup.sh && apt update && apt upgrade -y && update-grub && sleep 2 && apt-get update -y && sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/fisabiliyusri/SLXRAY/main/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh
```
