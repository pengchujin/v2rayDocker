# 一键V2ray websocket + TLS

一键就完事了，扫描二维码 或者 复制 vmess链接 无需关心复杂的V2ray 配置，websocket + tls 更安全，伪装更好。

* 自动生成 UUID （调用系统UUID库）
* 默认使用 caddy 自动获取证书
* 自动生成 安卓 v2rayNG vmess链接
* 自动生成 iOS shadowrocket vmess链接
* 自动生成 iOS 二维码

## 使用方法

 * 提前安装好docker 
 * 解析好域名 确认 你的域名正确解析到了你安装的这台服务器
 * 会占用 443 和 80 端口请提前确认没有跑其他的业务 （ lsof -i:80 和 lsof -i:443 能查看）
 * 请将下面命令 sebs.club 和 testV2ray 分别换成自己的 域名 和 节点名称！！！

```
sudo docker run -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws sebs.club testV2ray
```

* 跑完请复制保存好自己的 节点信息！（真心忘了或者丢了 sudo docker ps -a 查看 container id 然后 sudo docker stop containerID 重新跑就完事 ）

有问题欢迎提issue， 感谢 sebs.club。参考了 caddy docker 和 v2ray 的 docker 感谢！

