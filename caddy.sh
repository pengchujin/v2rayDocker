#!/bin/bash
# FILE="/etc/Caddy"
domain="$1"
ipv6domain="$2"
psname="$3"
uuid="51be9a06-299f-43b9-b713-1ec5eb76e3d7"
if  [ ! "$4" ] ;then
    uuid=$(uuidgen)
    echo "uuid 将会系统随机生成"
else
    uuid="$4"
fi
cat > /etc/Caddyfile <<'EOF'
domain
{
  log ../caddy.log
  proxy /one :2333 {
    websocket
    header_upstream -Origin
  }
}
ipv6
{
  log ../caddy.log
  proxy /one :2333 {
    websocket
    header_upstream -Origin
  }
}

EOF
sed -i "s/domain/${domain}/" /etc/Caddyfile
sed -i "s/ipv6/${ipv6domain}/" /etc/Caddyfile


# v2ray
cat > /etc/v2ray/config.json <<'EOF'
{
  "inbounds": [
    {
      "port": 2333,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "uuid",
            "alterId": 64
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "/one"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}

EOF

sed -i "s/uuid/${uuid}/" /etc/v2ray/config.json

cat > /srv/sebs.js <<'EOF'
 {
    "add":"domain",
    "aid":"0",
    "host":"",
    "id":"uuid",
    "net":"ws",
    "path":"/one",
    "port":"443",
    "ps":"sebsclub",
    "tls":"tls",
    "type":"none",
    "v":"2"
  }
EOF

if [ "$psname" != "" ] && [ "$psname" != "-c" ]; then
  sed -i "s/sebsclub/${psname}/" /srv/sebs.js
  sed -i "s/domain/${domain}/" /srv/sebs.js
  sed -i "s/uuid/${uuid}/" /srv/sebs.js
else
  $*
fi
pwd
# caddy must be started in another folder,otherwise the configuration will be leaked
mkdir -p /srv/temp/
cp /etc/Caddyfile /srv/temp
cd /srv/temp
nohup /bin/parent caddy  --log stdout --agree=false &
cd /srv/
echo "配置 JSON 详情"
echo " "
cat /etc/v2ray/config.json
echo " "
node v2ray.js
/usr/bin/v2ray -config /etc/v2ray/config.json
