# 一键 V2ray websocket + TLS

一键就完事了，扫描二维码 或者 复制 vmess链接 无需关心复杂的V2ray 配置，websocket + tls 更安全，伪装更好。

* 自动生成 UUID （调用系统UUID库）
* 默认使用 caddy 自动获取证书
* 自动生成 安卓 v2rayNG vmess链接
* 自动生成 iOS shadowrocket vmess链接
* 自动生成 iOS 二维码

## 使用方法

 * 提前安装好docker 
 ```
  curl -fsSL https://get.docker.com -o get-docker.sh  && \
  bash get-docker.sh
 ```
 * 解析好域名 确认 你的域名正确解析到了你安装的这台服务器
 * 会占用 443 和 80 端口请提前确认没有跑其他的业务 （ lsof -i:80 和 lsof -i:443 能查看）
 * 请将下面命令中的 YOURDOMAIN.COM（域名）替换成自己的域名（此IP解析的域名）！！！

```
sudo docker run -d --rm --name v2ray -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws:0.11 YOURDOMAIN.COM V2RAY_WS && sleep 3s && sudo docker logs v2ray
```
* 如果你想指定固定 uuid 的话， 0890b53a-e3d4-4726-bd2b-52574e8588c4 这个 uuid 改为你自己的，https://www.uuidgenerator.net/ 这个网站可以生成随机 uuid。
```
sudo docker run -d --rm --name v2ray -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws:0.11 YOURDOMAIN.COM V2RAY_WS 0890b53a-e3d4-4726-bd2b-52574e8588c4 && sleep 3s && sudo docker logs v2ray
```

* 命令执行完会显示链接信息，如果想查看链接信息，执行下面命令即可
```
sudo docker logs v2ray
```
* 想停止这个 docker 和服务
```
sudo docker stop v2ray
```

有问题欢迎提issue， 感谢大家。参考了 caddy docker 和 v2ray 的 dockerfile 感谢！

